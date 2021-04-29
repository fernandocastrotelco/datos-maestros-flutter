import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SistemasDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<SistemasBloc>();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
            child: Column(
          children: [
            Divider(thickness: 1),
            Expanded(child: BlocBuilder<SistemasBloc, SistemasState>(
                builder: (context, state) {
              if (state is SistemasSuccessState) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text:
                                              "Manejo de Sistemas y Permisos de un Sistema",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                      if (state.sistemas.isNotEmpty)
                                        Text.rich(TextSpan(
                                          text:
                                              "${state.seleccionado.id} - ${state.seleccionado.sistema}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ))
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                if (1 == 1)
                                  Text(
                                    "${state.seleccionado.updatedAt}",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            Divider(
                              thickness: 1,
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Rol: ${state.seleccionado.id} - ${state.seleccionado.sistema}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: kPrimaryColor),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.edit_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Editar",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {
                                                  _bloc.add(CrudSistemaEvent(
                                                      Crud.Update));
                                                  Navigator.pushNamed(context,
                                                      '/sistemas/edit');
                                                }),
                                            SizedBox(
                                              width: kDefaultPadding,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: kPrimaryColor),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      "Rol",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () {
                                                  context.read<RolesBloc>().add(
                                                      GetRolesEvent(Pagina(
                                                          numero: 0,
                                                          tamanio: 0,
                                                          consulta: "")));
                                                  _showMyDialog(context,
                                                      sistema: state
                                                          .seleccionado.id);
                                                }),
                                            SizedBox(
                                              width: kDefaultPadding * 3,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: kDefaultPadding),
                                        DataTable(
                                          columns: [
                                            DataColumn(label: Text("#")),
                                            DataColumn(label: Text("Scope")),
                                            DataColumn(label: Text("Rol")),
                                            DataColumn(label: Text("Activo")),
                                            DataColumn(label: Text("Acciones"))
                                          ],
                                          rows: state.seleccionado.roles
                                              .map((rol) {
                                            return DataRow(cells: [
                                              DataCell(Text('${rol.id}')),
                                              DataCell(Text('${rol.scope}')),
                                              DataCell(Text('${rol.rol}')),
                                              DataCell(rol.activo == 1
                                                  ? Icon(Icons
                                                      .check_circle_outline_rounded)
                                                  : Icon(Icons
                                                      .remove_circle_outline_rounded)),
                                              DataCell(Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.edit),
                                                    onPressed: () {
                                                      context
                                                          .read<RolesBloc>()
                                                          .add(GetRolesEvent(
                                                              Pagina(
                                                                  numero: 1,
                                                                  tamanio: 5,
                                                                  consulta: rol
                                                                      .rol)));
                                                      Navigator.pushNamed(
                                                          context, '/roles');
                                                    },
                                                  ),
                                                ],
                                              ))
                                            ]);
                                          }).toList(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            })),
          ],
        )),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, {int sistema}) async {
    //context.read<PermisosBloc>().add(GetPermisosEvent(""));
    final _width = context.size.width;
    int idRol;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Roles'),
          content: SingleChildScrollView(
            child: Container(
              width: _width / 1.5,
              child: ListBody(
                children: <Widget>[
                  Text('Seleccione el rol que desea agregar.'),
                  BlocBuilder<RolesBloc, RolesState>(builder: (context, state) {
                    if (state is RolesSuccessState) {
                      return DropdownSearch<Rol>(
                        label: "Permisos",
                        mode: Mode.MENU,
                        maxHeight: _width / 2,
                        //items: state.permisos,
                        itemAsString: (rol) => "${rol.rol} - ${rol.scope}",
                        showSearchBox: true,
                        onFind: (String filtro) =>
                            _getRoles(filtro, state.roles, context),
                        onChanged: (rol) {
                          print(rol.scope);
                          idRol = rol.id;
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Aceptar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: EdgeInsets.all(kDefaultPadding)),
              onPressed: () {
                context.read<SistemasBloc>().add(AddRolEvent(sistema, idRol));
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                  primary: kBadgeColor,
                  padding: EdgeInsets.all(kDefaultPadding)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<List<Rol>> _getRoles(
    String filtro, List<Rol> roles, BuildContext context) async {
  return roles;
}
