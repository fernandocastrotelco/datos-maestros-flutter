import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'permiso_form_state.dart';

class PermisoFormCubit extends Cubit<PermisoFormState> {
  final PermisosBloc _bloc;
  PermisoFormCubit({PermisosBloc bloc})
      : _bloc = bloc,
        super(PermisoFormState());

  final permisoController = TextEditingController();
  final scopeController = TextEditingController();
  final descripcionController = TextEditingController();

  void init() {
    final currentState = _bloc.state as PermisosPagedState;
    permisoController.text = currentState.seleccionado.permiso;
    scopeController.text = currentState.seleccionado.scope;
    descripcionController.text = currentState.seleccionado.descripcion;
    emit(PermisoFormState(
      id: currentState.seleccionado.id,
      permiso: currentState.seleccionado.permiso,
      scope: currentState.seleccionado.scope,
      descripcion: currentState.seleccionado.descripcion,
      activo: currentState.seleccionado.activo == 1,
      isEdit: currentState.seleccionado.id == 0,
    ));
  }

  void submitForm() {
    _bloc.add(SubmitPermisoEvent(
      id: state.id ?? 0,
      permiso: permisoController.text,
      scope: scopeController.text,
      descripcion: descripcionController.text,
      activo: state.activo ? 1 : 0,
    ));
  }

  void editable() {
    final e = state.isEdit;
    emit(state.copyWith(isEdit: !e));
  }

  void activoChanged(bool b) {
    emit(state.copyWith(activo: b));
  }
}
