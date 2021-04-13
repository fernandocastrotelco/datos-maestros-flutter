import 'dart:async';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_usuarios.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'usuarios_event.dart';
part 'usuarios_state.dart';

class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  final GetUsuarios _getUsuarios;
  UsuariosBloc(GetUsuarios getUsuarios)
      : assert(GetUsuarios != null),
        _getUsuarios = getUsuarios,
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
}
