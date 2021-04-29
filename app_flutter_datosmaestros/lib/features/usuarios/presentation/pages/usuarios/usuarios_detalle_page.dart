import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/usuarios/cubit/usuario_sistema_cubit.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants.dart';

class UsuariosDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<UsuariosBloc>();
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
                  if (state is UsuariosErrorState) {
                    Center(
                      child: Card(
                        child: Column(
                          children: [
                            Text(state.mensaje),
                            CustomButton(
                              text: "Volver",
                              onPressed: () {
                                _bloc.add(GetUsuariosEvent(
                                    Pagina(numero: 1, tamanio: 5)));
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
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
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  UsuarioSistemaCubit>()
                                                              .init();
                                                          _showMyDialog(
                                                              context,
                                                              state.seleccionado
                                                                  .id);
                                                        }),
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
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.edit),
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                      RolesBloc>()
                                                                  .add(GetRolesEvent(Pagina(
                                                                      numero: 1,
                                                                      tamanio:
                                                                          5,
                                                                      consulta:
                                                                          rol.rol)));
                                                              Navigator
                                                                  .pushNamed(
                                                                      context,
                                                                      '/roles');
                                                            },
                                                          ),
                                                          IconButton(
                                                              icon: Icon(
                                                                  Icons.delete),
                                                              onPressed: () {
                                                                _showDeleteDialog(
                                                                    context,
                                                                    state
                                                                        .seleccionado
                                                                        .id,
                                                                    rol.id,
                                                                    rol.rol +
                                                                        " - " +
                                                                        rol.scope);
                                                              }),
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

  Future<void> _showMyDialog(BuildContext context, int idUsuario) async {
    int idRol;
    final _width = context.size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sistemas y Roles'),
          content: SingleChildScrollView(
            child: Container(
              width: _width / 1.5,
              child: ListBody(
                children: <Widget>[
                  Text('Seleccione el sistema al que desea dar acceso.'),
                  BlocBuilder<UsuarioSistemaCubit, UsuarioSistemaState>(
                      builder: (context, state) {
                    if (state is UsuarioSistemaState) {
                      return Column(
                        children: [
                          DropdownSearch<Sistema>(
                            label: "Sistemas",
                            mode: Mode.MENU,
                            maxHeight: _width / 2,
                            selectedItem: state.sistema,
                            itemAsString: (sistema) =>
                                "${sistema.id} - ${sistema.sistema}",
                            showSearchBox: true,
                            onFind: (String filtro) =>
                                _getSistemas(filtro, state.lovSistemas),
                            onChanged: (sistema) {
                              context
                                  .read<UsuarioSistemaCubit>()
                                  .sistemaChanged(sistema);
                            },
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          DropdownSearch<Rol>(
                            label: "Roles",
                            mode: Mode.MENU,
                            maxHeight: _width / 2,
                            selectedItem: state.rol,
                            itemAsString: (rol) => "${rol.rol} - ${rol.scope}",
                            showSearchBox: true,
                            onFind: (String filtro) =>
                                _getRoles(filtro, state.lovRoles),
                            onChanged: (rol) {
                              context
                                  .read<UsuarioSistemaCubit>()
                                  .rolChanged(rol);
                              idRol = rol.id;
                            },
                          ),
                        ],
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
                context
                    .read<UsuariosBloc>()
                    .add(AddUsuarioRolEvent(idUsuario, idRol));
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

  Future<void> _showDeleteDialog(BuildContext context, int idUsuario, int idRol,
      String descripcion) async {
    final _width = context.size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Está seguro de eliminar el rol:'),
          content: SingleChildScrollView(
            child: Container(
              width: _width / 1.5,
              child: ListBody(
                children: <Widget>[
                  Text(
                    descripcion,
                    style: Theme.of(context).textTheme.headline6,
                  )
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
                context
                    .read<UsuariosBloc>()
                    .add(DeleteUsuarioRolEvent(idUsuario, idRol));
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

  Future<List<Sistema>> _getSistemas(
      String filtro, List<Sistema> sistemas) async {
    return sistemas;
  }

  Future<List<Rol>> _getRoles(String filtro, List<Rol> roles) async {
    return roles;
  }
}
