import 'dart:async';

import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/post_permiso.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'permisos_event.dart';
part 'permisos_state.dart';

class PermisosBloc extends Bloc<PermisosEvent, PermisosState> {
  final GetPermisos _getPermisos;
  final GetPermisosPage _getPermisosPage;
  final DeletePermiso _deletePermiso;
  final PostPermiso _postPermiso;
  PermisosBloc(GetPermisos getPermisos, GetPermisosPage getPermisosPage,
      DeletePermiso deletePermiso, PostPermiso postPermiso)
      : assert(getPermisos != null),
        _getPermisos = getPermisos,
        _getPermisosPage = getPermisosPage,
        _deletePermiso = deletePermiso,
        _postPermiso = postPermiso,
        super(PermisosInitial());

  @override
  Stream<PermisosState> mapEventToState(
    PermisosEvent event,
  ) async* {
    if (event is GetPermisosEvent) {
      yield* _mapGetPermisos(event);
    }
    if (event is GetPermisosPagedEvent) {
      yield* _mapGetPermisosPaged(event);
    }
    if (event is SelectPermisoEvent) {
      yield* _mapSelectPermisoEvent(event);
    }
    if (event is DeletePermisoEvent) {
      yield* _mapDeletePermisoEvent(event);
    }
    if (event is CreatePermisoEvent) {
      yield* _mapCreatePermisoEvent(event);
    }
    if (event is SubmitPermisoEvent) {
      yield* _mapSubmitPermisoEvent(event);
    }
  }

  Stream<PermisosState> _mapGetPermisos(GetPermisosEvent event) async* {
    yield PermisosLoadingState();
    final response = await _getPermisos(event.rol);
    yield response.fold(
        (failure) => PermisosErrorState("Error al obtener permisos"),
        (permisos) => PermisosSuccessState(permisos));
  }

  Stream<PermisosState> _mapGetPermisosPaged(
      GetPermisosPagedEvent event) async* {
    yield PermisosLoadingState();
    final response = await _getPermisosPage(event.pagina);
    yield response.fold(
        (failure) => PermisosErrorState(
            failure is ServerFailure ? failure.message : "Error"), (permiso) {
      final seleccionado =
          permiso.data.isNotEmpty ? permiso.data.first : Permiso();

      return PermisosPagedState(
          permiso.data,
          Pagina(
              numero: permiso.numero,
              tamanio: permiso.tamanio,
              total: permiso.total,
              registros: permiso.registros),
          seleccionado: seleccionado);
    });
  }

  Stream<PermisosState> _mapSelectPermisoEvent(
      SelectPermisoEvent event) async* {
    final currentState = state;
    yield PermisosLoadingState();
    if (currentState is PermisosPagedState) {
      Permiso permiso = currentState.permisos[event.index];
      yield currentState.copyWith(seleccionado: permiso);
    } else {
      yield PermisosErrorState("Error al obtener permiso seleccionado");
    }
  }

  Stream<PermisosState> _mapDeletePermisoEvent(
      DeletePermisoEvent event) async* {
    yield PermisosLoadingState();
    final response = await _deletePermiso(event.id);
    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          PermisosErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      this.add(GetPermisosPagedEvent(Pagina(numero: 1, tamanio: 5)));
    }
  }

  Stream<PermisosState> _mapCreatePermisoEvent(
      CreatePermisoEvent event) async* {
    final currentState = state as PermisosPagedState;
    yield currentState.copyWith(
        seleccionado:
            Permiso(id: 0, permiso: "", scope: "", descripcion: "", activo: 0));
  }

  Stream<PermisosState> _mapSubmitPermisoEvent(
      SubmitPermisoEvent event) async* {
    yield PermisosLoadingState();
    final Permiso request = Permiso(
        id: event.id,
        permiso: event.permiso,
        scope: event.scope,
        descripcion: event.descripcion,
        activo: event.activo);
    final response = await _postPermiso(request);

    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          PermisosErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      this.add(GetPermisosPagedEvent(Pagina(numero: 1, tamanio: 5)));
    }
  }
}
