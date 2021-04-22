import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/cubit/permiso_form_cubit.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/permiso_card.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/permiso_pagination.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/permisos_detalle_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermisosList extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<PermisosBloc>();
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
            child: BlocConsumer<PermisosBloc, PermisosState>(
                listener: (context, state) {
              if (state is PermisosPagedState) {
                context.read<PermisoFormCubit>().init();
              }
            }, builder: (context, state) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                              if (state is PermisosPagedState) {
                                Pagina pagina = Pagina(
                                  numero: state.pagina.numero,
                                  tamanio: state.pagina.tamanio,
                                  consulta: value,
                                );
                                _bloc.add(GetPermisosPagedEvent(pagina));
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: BlocBuilder<PermisosBloc, PermisosState>(
                        builder: (context, state) {
                      if (state is PermisosPagedState) {
                        return PermisoPagination(
                          bloc: _bloc,
                          pagina: state.pagina,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: kPrimaryColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                "Permiso",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () {
                            _bloc.add(CreatePermisoEvent());
                          }),
                      SizedBox(
                        width: kDefaultPadding,
                      )
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<PermisosBloc, PermisosState>(
                        builder: (context, state) {
                      if (state is PermisosPagedState) {
                        return ListView.builder(
                            itemCount: state.permisos.length,
                            itemBuilder: (context, index) => PermisoCard(
                                isActive: Responsive.isMobile(context)
                                    ? false
                                    : state.permisos[index].id ==
                                        state.seleccionado.id,
                                permiso: state.permisos[index],
                                press: () {
                                  _bloc.add(SelectPermisoEvent(index));
                                  if (!Responsive.isDesktop(context))
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PermisosDetallePage(),
                                        ));
                                }));
                      }
                      if (state is PermisosLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
                  ),
                ],
              );
            })),
      ),
    );
  }
}
