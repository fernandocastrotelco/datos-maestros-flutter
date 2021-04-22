import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'sistema_form_state.dart';

class SistemaFormCubit extends Cubit<SistemaFormState> {
  SistemaFormCubit(this._bloc) : super(SistemaFormState());
  final SistemasBloc _bloc;
  final sistemaController = TextEditingController();

  void editar(Sistema sistema) {
    sistemaController.text = sistema.sistema;
    emit(state.copyWith(
      id: sistema.id,
      activo: sistema.activo == 1,
    ));
  }

  void activoChanged(bool value) {
    emit(state.copyWith(activo: value));
  }

  Future<void> guardarSistema() async {
    _bloc.add(SubmitSistemaEvent(
        id: state.id,
        sistema: sistemaController.text,
        activo: state.activo ? 1 : 0));
  }
}
