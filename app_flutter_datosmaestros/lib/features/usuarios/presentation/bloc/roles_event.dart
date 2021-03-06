part of 'roles_bloc.dart';

@immutable
abstract class RolesEvent extends Equatable {
  const RolesEvent();
}

class GetRolesEvent extends RolesEvent {
  final Pagina pagina;

  GetRolesEvent(this.pagina);

  @override
  List<Object> get props => [pagina];
}

class SelectRolEvent extends RolesEvent {
  final int index;

  SelectRolEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CrudRolEvent extends RolesEvent {
  final Crud crud;

  CrudRolEvent(this.crud);

  @override
  List<Object> get props => [crud];
}

class DeleteRolEvent extends RolesEvent {
  final int id;

  DeleteRolEvent(this.id);

  @override
  List<Object> get props => [id];
}

class AddPermisoEvent extends RolesEvent {
  final int rol;
  final int permiso;

  AddPermisoEvent(this.rol, this.permiso);

  @override
  List<Object> get props => [rol, permiso];
}

class SubmitRolEvent extends RolesEvent {
  final int id;
  final int sistemasId;
  final String rol;
  final String scope;
  final String descripcion;
  final int activo;

  SubmitRolEvent(
      {this.id,
      this.sistemasId,
      this.rol,
      this.scope,
      this.descripcion,
      this.activo});

  @override
  List<Object> get props => [id, sistemasId, rol, scope, descripcion, activo];
}
