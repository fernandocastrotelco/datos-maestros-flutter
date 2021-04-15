import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/usuario_card.dart';
import 'components/usuarios_pagination.dart';
import 'usuarios_detalle_page.dart';

class ListOfUsuarios extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<UsuariosBloc>();
    return Scaffold(
        key: _scaffoldKey,
        drawer: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(color: Colors.white, child: SideMenu()),
        ),
        body: Container(
          padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
          color: kBgDarkColor,
          child: SafeArea(
              right: false,
              child: BlocBuilder<UsuariosBloc, UsuariosState>(
                  builder: (context, state) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Row(
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {
                                _scaffoldKey.currentState.openDrawer();
                              },
                            ),
                          if (!Responsive.isDesktop(context))
                            SizedBox(
                              width: 5,
                            ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                if (state is UsuariosSuccessState) {
                                  Pagina pagina = Pagina(
                                      numero: state.pagina.numero,
                                      tamanio: state.pagina.tamanio,
                                      consulta: value);
                                  _bloc.add(GetUsuariosEvent(pagina));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Buscar",
                                fillColor: kBgLightColor,
                                filled: true,
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(
                                      kDefaultPadding * 0.75), //15
                                  child: Icon(
                                    Icons.search,
                                    size: 24,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: BlocBuilder<UsuariosBloc, UsuariosState>(
                          builder: (context, state) {
                        if (state is UsuariosSuccessState) {
                          return UsuariosPagination(
                              bloc: _bloc, pagina: state.pagina);
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Expanded(
                      child: BlocBuilder<UsuariosBloc, UsuariosState>(
                          builder: (context, state) {
                        if (state is UsuariosSuccessState) {
                          return ListView.builder(
                              itemCount: state.usuarios.length,
                              itemBuilder: (context, index) => UsuarioCard(
                                  isActive: Responsive.isMobile(context)
                                      ? false
                                      : state.usuarios[index].id ==
                                          state.seleccionado.id,
                                  usuario: state.usuarios[index],
                                  press: () {
                                    _bloc.add(SelectUsuarioEvent(index));
                                    if (!Responsive.isDesktop(context))
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UsuariosDetallePage(),
                                          ));
                                  }));
                        }
                        if (state is UsuariosLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    )
                  ],
                );
              })),
        ));
  }
}
