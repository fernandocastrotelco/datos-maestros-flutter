import 'dart:async';

import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_roles.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'roles_event.dart';
part 'roles_state.dart';

class RolesBloc extends Bloc<RolesEvent, RolesState> {
  final GetRoles _getRoles;
  final GetSistemas _getSistemas;
  RolesBloc(GetRoles getRoles, GetSistemas getSistemas)
      : assert(getRoles != null, getSistemas != null),
        _getRoles = getRoles,
        _getSistemas = getSistemas,
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
    List<Sistema> sistemas = [];
    final currentState = state;
    final response = await _getSistemas(NoParams());
    sistemas = response.getOrElse(() => []);
    Rol rolVacio = Rol();
    if (currentState is RolesSuccessState) {
      yield RolesCrudState(
          event.crud == Crud.Create ? currentState.seleccionado : rolVacio,
          sistemas);
    }
  }

  Stream<RolesState> _mapSubmitRolEvent(SubmitRolEvent event) async* {
    yield RolesLoadingState();
    print("Rol submit: id: ${event.id} \n"
        " rol: ${event.rol} \n"
        " scope: ${event.scope} \n"
        " sistema id: ${event.sistemasId}"
        " descripcion: ${event.descripcion} \n");
    yield* _mapGetRolesEvent(GetRolesEvent(Pagina(numero: 1, tamanio: 5)));
  }
}
