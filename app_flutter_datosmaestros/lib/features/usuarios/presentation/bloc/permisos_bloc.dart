import 'dart:async';

import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'permisos_event.dart';
part 'permisos_state.dart';

class PermisosBloc extends Bloc<PermisosEvent, PermisosState> {
  final GetPermisos _getPermisos;
  PermisosBloc(GetPermisos getPermisos)
      : assert(getPermisos != null),
        _getPermisos = getPermisos,
        super(PermisosInitial());

  @override
  Stream<PermisosState> mapEventToState(
    PermisosEvent event,
  ) async* {
    if (event is GetPermisosEvent) {
      yield* _mapGetPermisos(event);
    }
  }

  Stream<PermisosState> _mapGetPermisos(GetPermisosEvent event) async* {
    yield PermisosLoadingState();
    final response = await _getPermisos(event.consulta);
    yield response.fold(
        (failure) => PermisosErrorState("Error al obtener permisos"),
        (permisos) => PermisosSuccessState(permisos));
  }
}
