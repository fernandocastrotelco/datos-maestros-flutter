import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_localidades.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_provincias.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'usuario_nuevo_state.dart';

class UsuarioNuevoCubit extends Cubit<UsuarioNuevoState> {
  final GetProvincias _getProvincias;
  final GetLocalidades _getLocalidades;
  final GetPersona _getPersona;
  UsuarioNuevoCubit(
    GetProvincias getProvincias,
    GetLocalidades getLocalidades,
    GetPersona getPersona,
  )   : _getProvincias = getProvincias,
        _getLocalidades = getLocalidades,
        _getPersona = getPersona,
        super(UsuarioNuevoState());

  final nameController = TextEditingController();
  final apellidoController = TextEditingController();
  final documentoController = TextEditingController();
  final calleController = TextEditingController();
  final numeroController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> init() async {
    final response = await _getProvincias(NoParams());
    final provincias = response.getOrElse(() => null);
    emit(state.copyWith(provincias: provincias));
  }

  Future<void> provinciaChange(Provincia provincia) async {
    final response = await _getLocalidades(provincia.id);
    final localidades = response.getOrElse(() => null);
    emit(state.copyWith(localidades: localidades, provincia: provincia));
  }

  Future<void> buscarPersona() async {
    print("sexo: ${state.sexo}");
    if (documentoController.text.isNotEmpty && state.sexo != null) {
      final response = await _getPersona(
          {"dni": documentoController.text, "sexo": state.sexo});
      final persona = response.getOrElse(() => null);
      if (persona.personaId != null) {
        nameController.text = persona.nombre;
        apellidoController.text = persona.apellido;
        calleController.text = persona.direccion;
        telefonoController.text = persona.telefono;
        correoController.text = persona.correo;

        final prov =
            Provincia(id: persona.provinciaId, provincia: persona.provincia);
        final loc =
            Localidad(id: persona.localidadId, localidad: persona.localidad);

        emit(state.copyWith(
            id: persona.personaId,
            nombre: persona.nombre,
            apellido: persona.apellido,
            documento: persona.documento,
            localidadId: persona.localidadId,
            calle: persona.direccion,
            telefono: persona.telefono,
            correo: persona.correo,
            localidad: loc,
            provincia: prov));
      }
    }
  }

  void localidadChanged(Localidad l) {
    emit(state.copyWith(localidadId: l.id, localidad: l));
  }

  void sexoChanged(String i) {
    emit(state.copyWith(sexo: i));
  }

  void stepContinue() {
    int ind = state.index;
    switch (state.index) {
      case 0:
        if (validar0()) ind++;
        break;
      case 1:
        ind++;
        break;
    }
    emit(state.copyWith(index: ind));
  }

  bool validar0() {
    bool result = true;
    if (state.documento?.isEmpty ?? true) {
      emit(state.copyWith(
          documentoError: "Debe indicar un número de documento"));
      result = false;
    }
    if (state.sexo?.isEmpty ?? true) {
      emit(state.copyWith(sexoError: "Debe seleccionar un sexo"));
      result = false;
    }
    if (result) emit(state.copyWith(documentoError: null, sexoError: null));
    return result;
  }

  bool validar2() {
    bool result = true;
    if (correoController.text?.isEmpty ?? true) {
      emit(state.copyWith(correoError: "Debe indicar un correo electrónico"));
      result = false;
    }
    if (passwordController.text?.isEmpty ?? true) {
      emit(state.copyWith(passwordError: "Debe seleccionar una contraseña"));
      result = false;
    }
    if (passwordController.text != confirmController.text) {
      emit(state.copyWith(
          passwordError: "La contraseña y su confirmación no coinciden"));
      result = false;
    }
    if (result) {
      emit(state.copyWith(
          correoError: null,
          passwordError: null,
          correo: correoController.text,
          password: passwordController.text,
          confirm: confirmController.text,
          calle: calleController.text,
          numero: numeroController.text,
          telefono: telefonoController.text));
    }

    return result;
  }
}
