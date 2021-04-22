import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'rol_form_state.dart';

class RolFormCubit extends Cubit<RolFormState> {
  RolFormCubit(this._bloc, this._getSistemas) : super(RolFormState());
  final RolesBloc _bloc;
  final GetSistemas _getSistemas;
  final rolController = TextEditingController();
  final scopeController = TextEditingController();
  final descripcionController = TextEditingController();

  void init() async {
    final response = await _getSistemas(NoParams());
    final sistemas = response.getOrElse(() => []);
    emit(state.copyWith(sistemas: sistemas));
  }

  void editar(Rol rol) {
    rolController.text = rol.rol;
    scopeController.text = rol.scope;
    descripcionController.text = rol.descripcion;
    emit(state.copyWith(
      id: rol.id,
      sistemaId: rol.sistemasId,
      activo: rol.activo == 1,
    ));
  }

  void sistemaIdChanged(int value) {
    emit(state.copyWith(sistemaId: value));
  }

  void activoChanged(bool value) {
    emit(state.copyWith(activo: value));
  }

  Future<void> guardarRol() async {
    _bloc.add(SubmitRolEvent(
        id: state.id,
        sistemasId: state.sistemaId,
        rol: rolController.text,
        scope: scopeController.text,
        descripcion: descripcionController.text,
        activo: state.activo ? 1 : 0));
  }
}
