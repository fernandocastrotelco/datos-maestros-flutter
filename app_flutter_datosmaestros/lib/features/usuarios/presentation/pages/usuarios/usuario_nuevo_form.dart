import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/usuario_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/usuarios/cubit/usuario_nuevo_cubit.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsuarioNuevoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cubit = context.read<UsuarioNuevoCubit>();
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
        child: Column(
          children: [
            SizedBox(
              height: kDefaultPadding * 2,
            ),
            Text(
              "Nuevo Usuario",
              style: Theme.of(context).textTheme.headline5,
            ),
            BlocBuilder<UsuarioNuevoCubit, UsuarioNuevoState>(
                builder: (context, snapshot) {
              return Container(
                width: constraints.maxWidth > 850 ? 800 : constraints.maxWidth,
                height: constraints.maxHeight / 1.5,
                child: Stepper(
                  type: StepperType.horizontal,
                  currentStep: snapshot.index,
                  onStepTapped: (i) {
                    _cubit.emit(snapshot.copyWith(index: i));
                  },
                  onStepContinue: () {
                    _cubit.stepContinue();
                  },
                  onStepCancel: () {
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (snapshot.index == 2)
                          CustomButton(
                            onPressed: () {
                              if (_cubit.validar2()) {
                                final usuario = UsuarioModel(
                                  user: snapshot.correo,
                                  nombre: snapshot.nombre,
                                  password: snapshot.password,
                                  personasId: snapshot.id,
                                  activo: 1,
                                );
                                context
                                    .read<UsuariosBloc>()
                                    .add(CreateUsuarioEvent(usuario));
                              }
                            },
                            text: "Guardar",
                          ),
                        if (snapshot.index != 2)
                          CustomButton(
                            onPressed: onStepContinue,
                            text: "Siguiente",
                          ),
                        CustomButton(
                          onPressed: onStepCancel,
                          backgroundColor: kBadgeColor,
                          text: "Cancelar",
                        ),
                      ],
                    );
                  },
                  steps: [
                    Step(
                        title: Text(
                          "Persona",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        isActive: snapshot.index == 0,
                        content: Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding * 2,
                            ),
                            CustomTextField(
                                nameController: _cubit.nameController,
                                label: "Nombre",
                                icon: Icons.person),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.apellidoController,
                                label: "Apellido",
                                icon: Icons.person),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            Focus(
                              child: CustomTextField(
                                  nameController: _cubit.documentoController,
                                  label: "Documento",
                                  keyboardType: TextInputType.number,
                                  error: snapshot.documentoError,
                                  icon: Icons.badge),
                              onFocusChange: (change) {
                                _cubit.buscarPersona();
                              },
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            if (snapshot.sexoError != null)
                              Text(
                                snapshot.sexoError,
                                style: TextStyle(color: Colors.red),
                              ),
                            DropdownSearch<String>(
                              mode: Mode.MENU,
                              maxHeight: 100,
                              items: ["Masculino", "Femenino"],
                              label: "Sexo",
                              onChanged: (i) {
                                _cubit.sexoChanged(i.substring(0, 1));
                                _cubit.buscarPersona();
                              },
                            ),
                            SizedBox(
                              height: kDefaultPadding * 2,
                            ),
                          ],
                        )),
                    Step(
                        title: Text(
                          "Domicilio",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        isActive: snapshot.index == 1,
                        content: Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            DropdownSearch<Provincia>(
                              mode: Mode.MENU,
                              items: snapshot.provincias,
                              selectedItem: snapshot.provincia,
                              itemAsString: (p) => p.provincia,
                              label: "Provincia",
                              onChanged: (p) {
                                _cubit.provinciaChange(p);
                              },
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            DropdownSearch<Localidad>(
                              mode: Mode.MENU,
                              enabled: snapshot.localidades != null,
                              selectedItem: snapshot.localidad,
                              items: snapshot.localidades,
                              itemAsString: (l) => l.localidad,
                              label: "Localidad",
                              onChanged: (l) {
                                _cubit.localidadChanged(l);
                              },
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.calleController,
                                label: "Calle",
                                icon: Icons.directions),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.numeroController,
                                label: "Número",
                                keyboardType: TextInputType.number,
                                icon: Icons.directions),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.telefonoController,
                                label: "Teléfono",
                                keyboardType: TextInputType.number,
                                icon: Icons.phone_iphone_rounded),
                            SizedBox(
                              height: kDefaultPadding * 2,
                            ),
                          ],
                        )),
                    Step(
                        title: Text(
                          "Usuario",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        isActive: snapshot.index == 2,
                        content: Column(
                          children: [
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                              nameController: _cubit.correoController,
                              label: "Correo",
                              error: snapshot.correoError,
                              icon: Icons.alternate_email_rounded,
                            ),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.passwordController,
                                label: "Contraseña",
                                error: snapshot.passwordError,
                                isPass: true,
                                icon: Icons.vpn_key_rounded),
                            SizedBox(
                              height: kDefaultPadding,
                            ),
                            CustomTextField(
                                nameController: _cubit.confirmController,
                                label: "Confirme la contraseña",
                                isPass: true,
                                icon: Icons.vpn_key_rounded),
                            SizedBox(
                              height: kDefaultPadding * 2,
                            ),
                          ],
                        )),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    ));
  }
}
