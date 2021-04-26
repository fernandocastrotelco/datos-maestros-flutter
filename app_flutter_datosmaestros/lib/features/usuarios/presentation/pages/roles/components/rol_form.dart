import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/roles/components/cubit/rol_form_cubit.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<RolesBloc>();
    final _cubit = context.read<RolFormCubit>();

    return BlocConsumer<RolesBloc, RolesState>(listener: (context, state) {
      if (state is RolesSuccessState) {
        Navigator.pushNamed(context, "/roles");
      }
      if (state is RolesErrorState) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
                backgroundColor: kBadgeColor,
                padding: EdgeInsets.all(kDefaultPadding * 4),
                content: Text(
                  state.mensaje,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                )),
          );
      }
    }, builder: (context, state) {
      if (state is RolesCrudState) {
        if (state.rol.id != null) {
          _cubit.editar(state.rol);
        }
      }
      return LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Card(
              elevation: 5,
              margin: EdgeInsets.all(kDefaultPadding),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 4),
                child: BlocBuilder<RolFormCubit, RolFormState>(
                    builder: (context, cubitState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Text(
                        "Roles",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Divider(
                        height: kDefaultPadding,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      if (cubitState.sistemas != null)
                        DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: cubitState.sistemas
                              .map((e) => e.sistema)
                              .toList(),
                          label: "Sistema",
                          hint: "Sistema al que pertenece el rol",
                          selectedItem: cubitState.sistemaId != null
                              ? cubitState.sistemas
                                  .firstWhere(
                                      (s) => s.id == cubitState.sistemaId)
                                  .sistema
                              : "",
                          onChanged: (i) {
                            final ind = cubitState.sistemas.indexWhere(
                                (element) => element.sistema.startsWith(i));
                            _cubit
                                .sistemaIdChanged(cubitState.sistemas[ind].id);
                          },
                        ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomTextField(
                          nameController: _cubit.rolController,
                          label: 'Rol',
                          icon: Icons.admin_panel_settings_rounded),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomTextField(
                          nameController: _cubit.scopeController,
                          label: 'Scope',
                          icon: Icons.admin_panel_settings_rounded),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomTextField(
                          nameController: _cubit.descripcionController,
                          label: 'Descripción',
                          icon: Icons.admin_panel_settings_outlined),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Activo:"),
                          Switch(
                            value: cubitState.activo,
                            onChanged: (b) {
                              _cubit.activoChanged(b);
                            },
                            activeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            text: 'Guardar',
                            onPressed: () {
                              _cubit.guardarRol();
                            },
                          ),
                          CustomButton(
                            text: 'Cancelar',
                            backgroundColor: kBadgeColor,
                            onPressed: () {
                              _bloc.add(
                                  GetRolesEvent(Pagina(numero: 1, tamanio: 5)));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
