import 'dart:async';

import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_roles.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/post_rol.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  final GetRoles _getRoles;
  final DeleteRol _deleteRol;
  final PostRol _postRol;
  final AddPermiso _addPermiso;
  RolesBloc(GetRoles getRoles, DeleteRol deleteRol, PostRol postRol,
      AddPermiso addPermiso)
      : assert(getRoles != null, deleteRol != null),
        _getRoles = getRoles,
        _deleteRol = deleteRol,
        _postRol = postRol,
        _addPermiso = addPermiso,
        super(RolesInitial());

  @override
  Stream<RolesState> mapEventToState(
    RolesEvent event,
  ) async* {
    if (event is GetRolesEvent) {
      yield* _mapGetRolesEvent(event);
    }
    if (event is SelectRolEvent) {
      yield* _mapSelectRolEvent(event);
    }
    if (event is CrudRolEvent) {
      yield* _mapCrudRolEvent(event);
    }
    if (event is SubmitRolEvent) {
      yield* _mapSubmitRolEvent(event);
    }
    if (event is DeleteRolEvent) {
      yield* _mapDeleteRolEvent(event);
    }
    if (event is AddPermisoEvent) {
      yield* _mapAddPermisosEvent(event);
    }
  }

  Stream<RolesState> _mapGetRolesEvent(GetRolesEvent event) async* {
    yield RolesLoadingState();
    final response = await _getRoles(event.pagina);
    yield response.fold(
        (failure) => RolesErrorState(
            failure is ServerFailure ? failure.message : "Error"), (roles) {
      final seleccionado = roles.data.isNotEmpty ? roles.data.first : Rol();

      return RolesSuccessState(
          roles.data,
          Pagina(
              numero: roles.numero,
              tamanio: roles.tamanio,
              total: roles.total,
              registros: roles.registros),
          seleccionado: seleccionado);
    });
  }

  Stream<RolesState> _mapSelectRolEvent(SelectRolEvent event) async* {
    final currentState = state;
    yield RolesLoadingState();
    if (currentState is RolesSuccessState) {
      Rol rol = currentState.roles[event.index];
      yield RolesSuccessState(
        currentState.roles,
        currentState.pagina,
        seleccionado: rol,
      );
    } else {
      yield RolesErrorState("Error al obtener rol seleccionado");
    }
  }

  Stream<RolesState> _mapCrudRolEvent(CrudRolEvent event) async* {
    final currentState = state;
    Rol rolVacio = Rol();
    if (currentState is RolesSuccessState) {
      yield RolesCrudState(
          event.crud == Crud.Create ? rolVacio : currentState.seleccionado);
    }
  }

  Stream<RolesState> _mapSubmitRolEvent(SubmitRolEvent event) async* {
    yield RolesLoadingState();
    final Rol request = Rol(
        id: event.id,
        rol: event.rol,
        scope: event.scope,
        sistemasId: event.sistemasId,
        descripcion: event.descripcion,
        activo: event.activo);
    final response = await _postRol(request);

    if (response.isLeft()) {
      var errorState;
      response.leftMap(
          (l) => errorState = RolesErrorState(_mapFailureToMessage(l)));
      yield errorState;
    } else {
      this.add(GetRolesEvent(Pagina(numero: 1, tamanio: 5)));
    }
  }

  Stream<RolesState> _mapDeleteRolEvent(DeleteRolEvent event) async* {
    yield RolesLoadingState();
    final response = await _deleteRol(event.id);
    if (response.isLeft()) {
      var errorState;
      response.leftMap(
          (l) => errorState = RolesErrorState(_mapFailureToMessage(l)));
      yield errorState;
    } else {
      this.add(GetRolesEvent(Pagina(numero: 1, tamanio: 5)));
    }
  }

  Stream<RolesState> _mapAddPermisosEvent(AddPermisoEvent event) async* {
    final currentState = state as RolesSuccessState;
    yield RolesLoadingState();
    final response =
        await _addPermiso({'rol': event.rol, 'permiso': event.permiso});
    if (response.isLeft()) {
      var errorState;
      response.leftMap(
          (l) => errorState = RolesErrorState(_mapFailureToMessage(l)));
      yield errorState;
    } else {
      final response2 = await _getRoles(currentState.pagina);
      yield response2.fold(
          (failure) => RolesErrorState(
              failure is ServerFailure ? failure.message : "Error"), (roles) {
        final rol =
            roles.data.firstWhere((e) => e.id == currentState.seleccionado.id);
        return RolesSuccessState(roles.data, currentState.pagina,
            seleccionado: rol);
      });
    }
  }
}

String _mapFailureToMessage(IFailure l) {
  if (l is ServerFailure) {
    return l.message;
  }
  return "";
}
