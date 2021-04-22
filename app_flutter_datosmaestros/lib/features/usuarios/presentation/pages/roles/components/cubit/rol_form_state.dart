part of 'rol_form_cubit.dart';

class RolFormState {
  final List<Sistema> sistemas;
  final int id;
  final int sistemaId;
  final String rol;
  final String scope;
  final String descripcion;
  final bool activo;

  RolFormState(
      {this.id = 0,
      this.sistemas,
      this.sistemaId,
      this.rol,
      this.scope,
      this.descripcion,
      this.activo = true});

  RolFormState copyWith({
    int id,
    List<Sistema> sistemas,
    int sistemaId,
    String rol,
    String scope,
    String descripcion,
    bool activo,
  }) {
    return RolFormState(
      id: id ?? this.id,
      sistemas: sistemas ?? this.sistemas,
      sistemaId: sistemaId ?? this.sistemaId,
      rol: rol ?? this.rol,
      scope: scope ?? this.scope,
      descripcion: descripcion ?? this.descripcion,
      activo: activo ?? this.activo,
    );
  }
}
