import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/components/cubit/sistema_form_cubit.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SistemaForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<SistemasBloc>();
    final _cubit = context.read<SistemaFormCubit>();

    return BlocConsumer<SistemasBloc, SistemasState>(
        listener: (context, state) {
      if (state is SistemasSuccessState) {
        Navigator.pushNamed(context, "/sistemas");
      }
      if (state is SistemasErrorState) {
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
      if (state is SistemasCrudState) {
        if (state.sistema.id != null) {
          _cubit.editar(state.sistema);
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
                child: BlocBuilder<SistemaFormCubit, SistemaFormState>(
                    builder: (context, cubitState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: kDefaultPadding * 2,
                      ),
                      Text(
                        "Sistemas",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Divider(
                        height: kDefaultPadding,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      CustomTextField(
                          nameController: _cubit.sistemaController,
                          label: 'Sistema',
                          icon: Icons.admin_panel_settings_rounded),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
                      SizedBox(
                        height: kDefaultPadding,
                      ),
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
                              _cubit.guardarSistema();
                            },
                          ),
                          CustomButton(
                            text: 'Cancelar',
                            backgroundColor: kBadgeColor,
                            onPressed: () {
                              _bloc.add(GetSistemasEvent(
                                  Pagina(numero: 1, tamanio: 5)));
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
