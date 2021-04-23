part of 'usuario_sistema_cubit.dart';

@immutable
class UsuarioSistemaState {
  final List<Sistema> lovSistemas;
  final Sistema sistema;
  final List<Rol> lovRoles;
  final Rol rol;

  UsuarioSistemaState(
      {this.lovSistemas, this.sistema, this.lovRoles, this.rol});

  UsuarioSistemaState copyWith({
    Sistema sistema,
    List<Sistema> sistemas,
    List<Rol> roles,
    Rol rol,
  }) {
    return UsuarioSistemaState(
        lovSistemas: sistemas ?? this.lovSistemas,
        sistema: sistema ?? this.sistema,
        lovRoles: roles ?? this.lovRoles,
        rol: rol ?? this.rol);
  }
}
