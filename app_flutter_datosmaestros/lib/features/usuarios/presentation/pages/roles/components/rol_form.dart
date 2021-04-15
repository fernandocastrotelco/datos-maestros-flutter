import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RolForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<RolesBloc>();
    var rolController = TextEditingController();
    var scopeController = TextEditingController();
    var descripcionController = TextEditingController();
    var sistemaId = 1;
    return BlocConsumer<RolesBloc, RolesState>(listener: (context, state) {
      if (state is RolesSuccessState) {
        Navigator.pushNamed(context, "/roles");
      }
    }, builder: (context, state) {
      if (state is RolesCrudState) {
        return LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  DropdownSearch<String>(
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: state.sistemas.map((e) => e.sistema).toList(),
                    label: "Sistema",
                    hint: "Sistema al que pertenece el rol",
                    onChanged: (i) {
                      final ind = state.sistemas.indexWhere(
                          (element) => element.sistema.startsWith(i));
                      sistemaId = state.sistemas[ind].id;
                      print("id seleccionado: $sistemaId");
                    },
                  ),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomTextField(
                      nameController: rolController,
                      label: 'Rol',
                      icon: Icons.admin_panel_settings_rounded),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomTextField(
                      nameController: scopeController,
                      label: 'Scope',
                      icon: Icons.admin_panel_settings_rounded),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  CustomTextField(
                      nameController: descripcionController,
                      label: 'Descripción',
                      icon: Icons.admin_panel_settings_outlined),
                  SizedBox(
                    height: kDefaultPadding * 2,
                  ),
                  CustomButton(
                    text: 'Guardar',
                    onPressed: () {
                      _bloc.add(SubmitRolEvent(
                          rol: rolController.text,
                          scope: scopeController.text,
                          sistemasId: sistemaId,
                          descripcion: descripcionController.text));
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
