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
