part of 'permiso_form_cubit.dart';

class PermisoFormState extends Equatable {
  final int id;
  final String permiso;
  final String scope;
  final String descripcion;
  final bool activo;
  final bool isEdit;

  PermisoFormState(
      {this.id,
      this.permiso,
      this.scope,
      this.descripcion,
      this.activo,
      this.isEdit = false});

  PermisoFormState copyWith({
    int id,
    String permiso,
    String scope,
    String descripcion,
    bool activo,
    bool isEdit,
  }) {
    return PermisoFormState(
      id: id ?? this.id,
      permiso: permiso ?? this.permiso,
      scope: scope ?? this.scope,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
      isEdit: isEdit ?? this.isEdit,
    );
  }

  @override
  List<Object> get props => [id, permiso, scope, descripcion, activo, isEdit];
}
