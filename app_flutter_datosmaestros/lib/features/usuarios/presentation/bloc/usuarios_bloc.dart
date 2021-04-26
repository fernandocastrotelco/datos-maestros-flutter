import 'dart:async';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_usuario_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_usuario_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_usuarios.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'usuarios_event.dart';
part 'usuarios_state.dart';

class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  final GetUsuarios _getUsuarios;
  final AddUsuarioRol _addUsuarioRol;
  final DeleteUsuarioRol _deleteUsuarioRol;
  UsuariosBloc(GetUsuarios getUsuarios, AddUsuarioRol addUsuarioRol,
      DeleteUsuarioRol deleteUsuarioRol)
      : assert(GetUsuarios != null),
        _getUsuarios = getUsuarios,
        _addUsuarioRol = addUsuarioRol,
        _deleteUsuarioRol = deleteUsuarioRol,
        super(UsuariosInitial());
  @override
  Stream<UsuariosState> mapEventToState(
    UsuariosEvent event,
  ) async* {
    if (event is GetUsuariosEvent) {
      yield* _mapGetUsuariosEvent(event);
    }
    if (event is SelectUsuarioEvent) {
      yield* _mapSelectUsuarioEvent(event);
    }
    if (event is AddUsuarioRolEvent) {
      yield* _mapAddUsuarioRolEvent(event);
    }
    if (event is DeleteUsuarioRolEvent) {
      yield* _mapDeleteUsuarioRolEvent(event);
    }
  }

  Stream<UsuariosState> _mapGetUsuariosEvent(GetUsuariosEvent event) async* {
    yield UsuariosLoadingState();
    final response = await _getUsuarios(event.pagina);
    yield response.fold(
        (failure) => UsuariosErrorState(
            failure is ServerFailure ? failure.message : "Error"), (usuarios) {
      final seleccionado =
          usuarios.data.isNotEmpty ? usuarios.data.first : Usuario();

      return UsuariosSuccessState(
          usuarios.data,
          Pagina(
              numero: usuarios.numero,
              tamanio: usuarios.tamanio,
              total: usuarios.total,
              registros: usuarios.registros),
          seleccionado: seleccionado);
    });
  }

  Stream<UsuariosState> _mapSelectUsuarioEvent(
      SelectUsuarioEvent event) async* {
    final currentState = state;
    yield UsuariosLoadingState();
    if (currentState is UsuariosSuccessState) {
      Usuario usuario = currentState.usuarios[event.index];
      yield UsuariosSuccessState(
        currentState.usuarios,
        currentState.pagina,
        seleccionado: usuario,
      );
    } else {
      yield UsuariosErrorState("Error al obtener usuario seleccionado");
    }
  }

  Stream<UsuariosState> _mapAddUsuarioRolEvent(
      AddUsuarioRolEvent event) async* {
    final currentState = state as UsuariosSuccessState;
    yield UsuariosLoadingState();
    final response =
        await _addUsuarioRol({'usuario': event.usuario, 'rol': event.rol});
    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          UsuariosErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      final response2 = await _getUsuarios(currentState.pagina);
      yield response2.fold(
          (failure) => UsuariosErrorState(
              failure is ServerFailure ? failure.message : "Error"),
          (usuarios) {
        final usuario = usuarios.data
            .firstWhere((e) => e.id == currentState.seleccionado.id);
        return UsuariosSuccessState(usuarios.data, currentState.pagina,
            seleccionado: usuario);
      });
    }
  }

  Stream<UsuariosState> _mapDeleteUsuarioRolEvent(
      DeleteUsuarioRolEvent event) async* {
    final currentState = state as UsuariosSuccessState;
    yield UsuariosLoadingState();
    final response =
        await _deleteUsuarioRol({'usuario': event.usuario, 'rol': event.rol});
    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          UsuariosErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      final response2 = await _getUsuarios(currentState.pagina);
      yield response2.fold(
          (failure) => UsuariosErrorState(
              failure is ServerFailure ? failure.message : "Error"),
          (usuarios) {
        final usuario = usuarios.data
            .firstWhere((e) => e.id == currentState.seleccionado.id);
        return UsuariosSuccessState(usuarios.data, currentState.pagina,
            seleccionado: usuario);
      });
    }
  }
}
