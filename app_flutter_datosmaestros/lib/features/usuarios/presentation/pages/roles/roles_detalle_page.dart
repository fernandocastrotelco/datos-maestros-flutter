import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolesDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final _bloc = context.read<RolesBloc>();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
            child: Column(
          children: [
            Divider(thickness: 1),
            Expanded(child:
                BlocBuilder<RolesBloc, RolesState>(builder: (context, state) {
              if (state is RolesSuccessState) {
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
                                              "Manejo de Roles y Permisos de un Sistema",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                      if (state.roles.isNotEmpty)
                                        Text(
                                          "${state.seleccionado.id} - ${state.seleccionado.rol}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        )
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
                                              "Rol: ${state.seleccionado.id} - ${state.seleccionado.rol}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                            Spacer(),
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
                                                      "Permiso",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                onPressed: () =>
                                                    _showMyDialog(context)),
                                          ],
                                        ),
                                        SizedBox(height: kDefaultPadding),
                                        DataTable(
                                          columns: [
                                            DataColumn(label: Text("#")),
                                            DataColumn(label: Text("Scope")),
                                            DataColumn(label: Text("Permiso")),
                                            DataColumn(label: Text("Activo")),
                                            DataColumn(label: Text("Acciones"))
                                          ],
                                          rows: state.seleccionado.permisos
                                              .map((permiso) {
                                            return DataRow(cells: [
                                              DataCell(Text('${permiso.id}')),
                                              DataCell(
                                                  Text('${permiso.scope}')),
                                              DataCell(
                                                  Text('${permiso.permiso}')),
                                              DataCell(permiso.activo == 1
                                                  ? Icon(Icons
                                                      .check_circle_outline_rounded)
                                                  : Icon(Icons
                                                      .remove_circle_outline_rounded)),
                                              DataCell(Row(
                                                children: [
                                                  IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {}),
                                                  Icon(Icons.delete)
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

  Future<void> _showMyDialog(BuildContext context) async {
    //context.read<PermisosBloc>().add(GetPermisosEvent(""));
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permisos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Seleccione el permiso que desea agregar.'),
                BlocBuilder<PermisosBloc, PermisosState>(
                    builder: (context, state) {
                  if (state is PermisosSuccessState) {
                    return DropdownSearch<Permiso>(
                      label: "Permisos",
                      mode: Mode.MENU,
                      items: state.permisos,
                      itemAsString: (permiso) =>
                          "${permiso.permiso} - ${permiso.scope}",
                      showSearchBox: true,
                      onFind: (String filtro) =>
                          _getPermisos(filtro, state.permisos, context),
                      onChanged: (permiso) {
                        print(permiso.scope);
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
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
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

Future<List<Permiso>> _getPermisos(
    String filtro, List<Permiso> permisos, BuildContext context) async {
  return permisos;
}
