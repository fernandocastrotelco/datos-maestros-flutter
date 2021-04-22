import 'dart:async';

import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/post_sistema.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sistemas_event.dart';
part 'sistemas_state.dart';

class SistemasBloc extends Bloc<SistemasEvent, SistemasState> {
  final GetSistemasPage _getSistemas;
  final PostSistema _postSistema;
  final AddRol _addRol;
  SistemasBloc(
      GetSistemasPage getSistemas, PostSistema postSistema, AddRol addRol)
      : _getSistemas = getSistemas,
        _postSistema = postSistema,
        _addRol = addRol,
        super(SistemasInitial());

  @override
  Stream<SistemasState> mapEventToState(
    SistemasEvent event,
  ) async* {
    if (event is GetSistemasEvent) {
      yield* _mapGetSistemasEvent(event);
    }
    if (event is SelectSistemaEvent) {
      yield* _mapSelectSistemaEvent(event);
    }
    if (event is CrudSistemaEvent) {
      yield* _mapCrudSistemaEvent(event);
    }
    if (event is SubmitSistemaEvent) {
      yield* _mapSubmitSistemaEvent(event);
    }
    if (event is AddRolEvent) {
      yield* _mapAddRolEvent(event);
    }
  }

  Stream<SistemasState> _mapGetSistemasEvent(GetSistemasEvent event) async* {
    yield SistemasLoadingState();
    final response = await _getSistemas(event.pagina);
    yield response.fold(
        (failure) => SistemasErrorState(
            failure is ServerFailure ? failure.message : "Error"), (sistema) {
      final seleccionado =
          sistema.data.isNotEmpty ? sistema.data.first : Sistema();

      return SistemasSuccessState(
          sistema.data,
          Pagina(
              numero: sistema.numero,
              tamanio: sistema.tamanio,
              total: sistema.total,
              registros: sistema.registros),
          seleccionado: seleccionado);
    });
  }

  Stream<SistemasState> _mapSelectSistemaEvent(
      SelectSistemaEvent event) async* {
    final currentState = state;
    yield SistemasLoadingState();
    if (currentState is SistemasSuccessState) {
      Sistema sistema = currentState.sistemas[event.index];
      yield SistemasSuccessState(
        currentState.sistemas,
        currentState.pagina,
        seleccionado: sistema,
      );
    } else {
      yield SistemasErrorState("Error al obtener sistema seleccionado");
    }
  }

  Stream<SistemasState> _mapCrudSistemaEvent(CrudSistemaEvent event) async* {
    final currentState = state;
    Sistema sistemaVacio = Sistema();
    if (currentState is SistemasSuccessState) {
      yield SistemasCrudState(
          event.crud == Crud.Create ? sistemaVacio : currentState.seleccionado);
    }
  }

  Stream<SistemasState> _mapSubmitSistemaEvent(
      SubmitSistemaEvent event) async* {
    yield SistemasLoadingState();
    final Sistema request =
        Sistema(id: event.id, sistema: event.sistema, activo: event.activo);
    final response = await _postSistema(request);

    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          SistemasErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      this.add(GetSistemasEvent(Pagina(numero: 1, tamanio: 5)));
    }
  }

  Stream<SistemasState> _mapAddRolEvent(AddRolEvent event) async* {
    final currentState = state as SistemasSuccessState;
    yield SistemasLoadingState();
    final response =
        await _addRol({'sistema': event.sistema, 'rol': event.rol});
    if (response.isLeft()) {
      var errorState;
      response.leftMap((l) => errorState =
          SistemasErrorState(l is ServerFailure ? l.message : "Error"));
      yield errorState;
    } else {
      final response2 = await _getSistemas(currentState.pagina);
      yield response2.fold(
          (failure) => SistemasErrorState(
              failure is ServerFailure ? failure.message : "Error"),
          (sistemas) {
        final sistema = sistemas.data
            .firstWhere((e) => e.id == currentState.seleccionado.id);
        return SistemasSuccessState(sistemas.data, currentState.pagina,
            seleccionado: sistema);
      });
    }
  }
}
