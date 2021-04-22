import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/components/cubit/sistema_form_cubit.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/components/sistema_form.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SistemasFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocProvider<SistemaFormCubit>(
      create: (context) => SistemaFormCubit(context.read<SistemasBloc>()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(color: Colors.white, child: SideMenu()),
        ),
        body: Responsive(
            mobile: SistemaForm(),
            tablet: Row(
              children: [
                Expanded(flex: 6, child: SideMenu()),
                Expanded(flex: 9, child: SistemaForm()),
              ],
            ),
            desktop: Row(
              children: [
                Expanded(flex: 3, child: SideMenu()),
                Expanded(flex: 10, child: SistemaForm()),
              ],
            )),
      ),
    );
  }
}
