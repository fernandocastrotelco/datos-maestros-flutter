import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';

import 'list_of_usuarios.dart';
import 'usuarios_detalle_page.dart';

class PrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
          mobile: ListOfUsuarios(),
          tablet: Row(
            children: [
              Expanded(
                flex: 6,
                child: ListOfUsuarios(),
              ),
              Expanded(
                flex: 9,
                child: UsuariosDetallePage(),
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
                  child: UsuariosDetallePage())
            ],
          )),
    );
  }
}
