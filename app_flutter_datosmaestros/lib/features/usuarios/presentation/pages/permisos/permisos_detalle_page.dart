import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/cubit/permiso_form_cubit.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/permiso_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermisosDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final _bloc = context.read<PermisosBloc>();
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
            child: Column(
          children: [
            Divider(thickness: 1),
            Expanded(child: BlocBuilder<PermisosBloc, PermisosState>(
                builder: (context, state) {
              if (state is PermisosPagedState) {
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
                                          text: "Manejo de Permisos",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                        ),
                                      ),
                                      if (state.seleccionado.id != 0)
                                        Text.rich(TextSpan(
                                          text:
                                              "${state.seleccionado.id} - ${state.seleccionado.permiso}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        )),
                                      if (state.seleccionado.id == 0)
                                        Text.rich(TextSpan(
                                          text: "NUEVO PERMISO",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ))
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                if (state.seleccionado.id != 0)
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BlocBuilder<PermisoFormCubit, PermisoFormState>(
                                  builder: (context, snapshot) {
                                    if (snapshot.isEdit) {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: kPrimaryColor),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.save_rounded,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "Guardar",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            context
                                                .read<PermisoFormCubit>()
                                                .submitForm();
                                          });
                                    } else {
                                      return ElevatedButton(
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
                                          context
                                              .read<PermisoFormCubit>()
                                              .editable();
                                        },
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: kDefaultPadding * 2,
                                ),
                                if (state.seleccionado.id != 0)
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: kBadgeColor),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_rounded,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Eliminar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        _showDeleteDialog(context,
                                            id: state.seleccionado.id,
                                            permiso: state.seleccionado.permiso,
                                            scope: state.seleccionado.scope);
                                      })
                              ],
                            ),
                            PermisoForm(permiso: state.seleccionado),
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

  Future<void> _showDeleteDialog(BuildContext context,
      {int id, String permiso, String scope}) async {
    final _width = context.size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Desea eliminar el permiso:'),
          content: SingleChildScrollView(
            child: Container(
              width: _width / 1.5,
              child: ListBody(
                children: <Widget>[
                  Text('$permiso - $scope'),
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
                context.read<PermisosBloc>().add(DeletePermisoEvent(id));
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
