import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../../../../responsive.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "telco.png",
                  width: 170,
                ),
                Spacer(),
                // We don't want to show this close button on Desktop mood
                if (!Responsive.isDesktop(context)) CloseButton(),
              ],
            ),
            Divider(
              height: kDefaultPadding,
            ),
            SizedBox(height: kDefaultPadding * 2),
            SideMenuItem(
              iconSrc: Icons.person_rounded,
              title: "Usuarios",
              press: () {
                Navigator.pushNamed(context, '/home');
              },
              isActive: ModalRoute.of(context).settings.name == '/' ||
                  ModalRoute.of(context).settings.name == '/home',
            ),
            SideMenuItem(
              iconSrc: Icons.personal_video_rounded,
              title: "Sistemas",
              press: () {},
              isActive: false,
            ),
            SideMenuItem(
              iconSrc: Icons.security_rounded,
              title: "Roles y Permisos",
              press: () {
                context
                    .read<RolesBloc>()
                    .add(GetRolesEvent(Pagina(numero: 1, tamanio: 5)));
                Navigator.pushNamed(context, '/roles');
              },
              isActive:
                  ModalRoute.of(context).settings.name.startsWith('/roles'),
            ),
          ],
        ),
      )),
    );
  }
}
