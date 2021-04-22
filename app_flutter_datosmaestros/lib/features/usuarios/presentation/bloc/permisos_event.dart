part of 'permisos_bloc.dart';

@immutable
abstract class PermisosEvent extends Equatable {
  const PermisosEvent();
}

class GetPermisosEvent extends PermisosEvent {
  final int rol;

  GetPermisosEvent(this.rol);
  @override
  List<Object> get props => [rol];
}

class SelectPermisoEvent extends PermisosEvent {
  final int index;

  SelectPermisoEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CreatePermisoEvent extends PermisosEvent {
  @override
  List<Object> get props => [];
}

class DeletePermisoEvent extends PermisosEvent {
  final int id;

  DeletePermisoEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetPermisosPagedEvent extends PermisosEvent {
  final Pagina pagina;

  GetPermisosPagedEvent(this.pagina);
  @override
  List<Object> get props => [pagina];
}

class SubmitPermisoEvent extends PermisosEvent {
  final int id;
  final String permiso;
  final String scope;
  final String descripcion;
  final int activo;

  SubmitPermisoEvent(
      {this.id, this.permiso, this.scope, this.descripcion, this.activo});

  @override
  List<Object> get props => [id, permiso, scope, descripcion, activo];
}
