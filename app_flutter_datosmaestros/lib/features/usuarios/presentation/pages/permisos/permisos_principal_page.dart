import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/cubit/permiso_form_cubit.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/permisos_detalle_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/permisos_list.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermisosPrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<PermisoFormCubit>(
        create: (_) =>
            PermisoFormCubit(bloc: context.read<PermisosBloc>())..init(),
        child: Responsive(
            mobile: PermisosList(),
            tablet: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: PermisosList(),
                ),
                Expanded(
                  flex: 9,
                  child: PermisosDetallePage(),
                )
              ],
            ),
            desktop: Row(
              children: [
                Expanded(
                  flex: _size.width > 1200.0 ? 2 : 4,
                  child: SideMenu(),
                ),
                Expanded(
                    flex: _size.width > 1200.0 ? 3 : 5, child: PermisosList()),
                Expanded(
                    flex: _size.width > 1200.0 ? 8 : 10,
                    child: PermisosDetallePage())
              ],
            )),
      ),
    );
  }
}
