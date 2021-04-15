import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/roles/roles_detalle_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';

import 'list_of_roles.dart';

class RolesPrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
          mobile: ListOfRoles(),
          tablet: Row(
            children: [
              Expanded(
                flex: 6,
                child: ListOfRoles(),
              ),
              Expanded(
                flex: 9,
                child: RolesDetallePage(),
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
                  flex: _size.width > 1200.0 ? 3 : 5, child: ListOfRoles()),
              Expanded(
                  flex: _size.width > 1200.0 ? 8 : 10,
                  child: RolesDetallePage())
            ],
          )),
    );
  }
}
