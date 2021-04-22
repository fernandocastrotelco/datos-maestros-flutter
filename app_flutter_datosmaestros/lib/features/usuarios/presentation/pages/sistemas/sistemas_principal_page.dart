import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/list_of_sistemas.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/sistemas_detalle_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/material.dart';

class SistemasPrincipalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Responsive(
          mobile: ListOfSistemas(),
          tablet: Row(
            children: [
              Expanded(
                flex: 6,
                child: ListOfSistemas(),
              ),
              Expanded(
                flex: 9,
                child: SistemasDetallePage(),
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
                  flex: _size.width > 1200.0 ? 3 : 5, child: ListOfSistemas()),
              Expanded(
                  flex: _size.width > 1200.0 ? 8 : 10,
                  child: SistemasDetallePage())
            ],
          )),
    );
  }
}
