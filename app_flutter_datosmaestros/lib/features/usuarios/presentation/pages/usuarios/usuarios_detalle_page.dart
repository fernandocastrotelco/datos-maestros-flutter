import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';

class UsuariosDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Divider(thickness: 1),
              Expanded(
                child: BlocBuilder<UsuariosBloc, UsuariosState>(
                    builder: (context, state) {
                  if (state is UsuariosSuccessState) {
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
                                                  "Manejo de Sistemas y Roles de un usuario",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .button,
                                            ),
                                          ),
                                          if (state.usuarios.isNotEmpty)
                                            Text(
                                              "${state.seleccionado.id} - ${state.seleccionado.user}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: kDefaultPadding / 2),
                                    if (state.usuarios.isNotEmpty)
                                      Text(
                                        "${state.seleccionado.updatedAt}",
                                        style:
                                            Theme.of(context).textTheme.caption,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (state.usuarios.isNotEmpty)
                                          Column(
                                              children: state
                                                  .seleccionado.sistemas
                                                  .map((sistema) {
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Sistema: ${sistema.id} - ${sistema.sistema}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                    ),
                                                    Spacer(),
                                                    ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    kPrimaryColor),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              "Agregar",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                        onPressed: () {}),
                                                  ],
                                                ),
                                                SizedBox(
                                                    height: kDefaultPadding),
                                                DataTable(
                                                  columns: [
                                                    DataColumn(
                                                        label: Text("#")),
                                                    DataColumn(
                                                        label: Text("Scope")),
                                                    DataColumn(
                                                        label: Text("Rol")),
                                                    DataColumn(
                                                        label: Text("Activo")),
                                                    DataColumn(
                                                        label: Text("Acciones"))
                                                  ],
                                                  rows:
                                                      sistema.roles.map((rol) {
                                                    return DataRow(cells: [
                                                      DataCell(
                                                          Text('${rol.id}')),
                                                      DataCell(
                                                          Text('${rol.scope}')),
                                                      DataCell(
                                                          Text('${rol.rol}')),
                                                      DataCell(rol.activo == 1
                                                          ? Icon(Icons
                                                              .check_circle_outline_rounded)
                                                          : Icon(Icons
                                                              .remove_circle_outline_rounded)),
                                                      DataCell(Row(
                                                        children: [
                                                          Icon(Icons.edit),
                                                          Icon(Icons.delete)
                                                        ],
                                                      ))
                                                    ]);
                                                  }).toList(),
                                                ),
                                              ],
                                            );
                                          }).toList()),
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
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
