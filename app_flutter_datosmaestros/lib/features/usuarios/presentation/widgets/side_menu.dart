import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';

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
              press: () {},
              isActive: true,
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
              press: () {},
              isActive: false,
            ),
          ],
        ),
      )),
    );
  }
}
