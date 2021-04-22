part of 'permisos_bloc.dart';

@immutable
abstract class PermisosState extends Equatable {}

class PermisosInitial extends PermisosState {
  @override
  List<Object> get props => [];
}

class PermisosLoadingState extends PermisosState {
  @override
  List<Object> get props => [];
}

class PermisosPagedState extends PermisosState {
  final List<Permiso> permisos;
  final Permiso seleccionado;
  final Pagina pagina;
  final Crud crud;
  static const Permiso permisoVacio = Permiso();
  PermisosPagedState(this.permisos, this.pagina,
      {this.seleccionado = permisoVacio, this.crud = Crud.Create});

  PermisosPagedState copyWith(
      {List<Permiso> permisos,
      Permiso seleccionado,
      int numero,
      int tamanio,
      String consulta,
      Crud crud}) {
    final nuevapagina = Pagina(
      numero: numero ?? pagina.numero,
      tamanio: tamanio ?? pagina.tamanio,
      consulta: consulta ?? pagina.consulta,
      total: pagina.total,
      registros: pagina.registros,
      data: pagina.data,
    );
    return PermisosPagedState(permisos ?? this.permisos, nuevapagina,
        seleccionado: seleccionado ?? this.seleccionado,
        crud: crud ?? this.crud);
  }

  @override
  List<Object> get props => [permisos, seleccionado, pagina, crud];
}

class PermisosSuccessState extends PermisosState {
  final List<Permiso> permisos;

  PermisosSuccessState(this.permisos);

  @override
  List<Object> get props => [permisos];
}

class PermisosErrorState extends PermisosState {
  final String mensaje;

  PermisosErrorState(this.mensaje);

  @override
  List<Object> get props => [];
}
