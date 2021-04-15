import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/roles/roles_detalle_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/side_menu.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';
import 'components/rol_card.dart';
import 'components/roles_pagination.dart';

class ListOfRoles extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<RolesBloc>();
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
            child:
                BlocBuilder<RolesBloc, RolesState>(builder: (context, state) {
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
                              if (state is RolesSuccessState) {
                                Pagina pagina = Pagina(
                                  numero: state.pagina.numero,
                                  tamanio: state.pagina.tamanio,
                                  consulta: value,
                                );
                                _bloc.add(GetRolesEvent(pagina));
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
                    child: BlocBuilder<RolesBloc, RolesState>(
                        builder: (context, state) {
                      if (state is RolesSuccessState) {
                        return RolesPagination(
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
                                "Rol",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          onPressed: () {
                            _bloc.add(CrudRolEvent(Crud.Create));
                            Navigator.pushNamed(context, '/roles/edit');
                          }),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<RolesBloc, RolesState>(
                        builder: (context, state) {
                      if (state is RolesSuccessState) {
                        return ListView.builder(
                            itemCount: state.roles.length,
                            itemBuilder: (context, index) => RolCard(
                                isActive: Responsive.isMobile(context)
                                    ? false
                                    : state.roles[index].id ==
                                        state.seleccionado.id,
                                rol: state.roles[index],
                                press: () {
                                  _bloc.add(SelectRolEvent(index));
                                  if (!Responsive.isDesktop(context))
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RolesDetallePage(),
                                        ));
                                }));
                      }
                      if (state is RolesLoadingState) {
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
