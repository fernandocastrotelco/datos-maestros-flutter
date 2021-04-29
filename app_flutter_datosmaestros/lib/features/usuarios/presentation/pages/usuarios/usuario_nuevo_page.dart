import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/usuarios/list_of_usuarios.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/usuarios/usuario_nuevo_form.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';

class UsuarioNuevoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
          mobile: UsuarioNuevoForm(),
          tablet: Row(
            children: [
              Expanded(
                flex: 6,
                child: ListOfUsuarios(),
              ),
              Expanded(
                flex: 9,
                child: UsuarioNuevoForm(),
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
                  flex: _size.width > 1200.0 ? 3 : 5, child: ListOfUsuarios()),
              Expanded(
                  flex: _size.width > 1200.0 ? 8 : 10,
                  child: UsuarioNuevoForm())
            ],
          )),
    );
  }
}
