import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/components/cubit/permiso_form_cubit.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PermisoForm extends StatelessWidget {
  final Permiso permiso;

  const PermisoForm({Key key, this.permiso}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermisoFormCubit, PermisoFormState>(
        builder: (context, snapshot) {
      final _cubit = context.read<PermisoFormCubit>();
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: kDefaultPadding * 2,
          ),
          CustomTextField(
              nameController: _cubit.permisoController,
              label: 'Nombre',
              readOnly: !snapshot.isEdit,
              icon: Icons.admin_panel_settings_rounded),
          SizedBox(
            height: kDefaultPadding,
          ),
          CustomTextField(
              nameController: _cubit.scopeController,
              label: 'Scope',
              readOnly: !snapshot.isEdit,
              icon: Icons.admin_panel_settings_rounded),
          SizedBox(
            height: kDefaultPadding,
          ),
          CustomTextField(
              nameController: _cubit.descripcionController,
              label: 'Descripción',
              readOnly: !snapshot.isEdit,
              icon: Icons.admin_panel_settings_outlined),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Activo:"),
              Switch(
                value: snapshot.activo,
                onChanged: (b) {
                  if (snapshot.isEdit) {
                    _cubit.activoChanged(b);
                  }
                },
                activeColor: kPrimaryColor,
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding * 2,
          ),
        ],
      );
    });
  }
}
