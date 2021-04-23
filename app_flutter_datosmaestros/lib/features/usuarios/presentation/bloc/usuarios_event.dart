part of 'usuarios_bloc.dart';

abstract class UsuariosEvent extends Equatable {
  const UsuariosEvent();
}

class GetUsuariosEvent extends UsuariosEvent {
  final Pagina pagina;

  GetUsuariosEvent(this.pagina);

  @override
  List<Object> get props => [pagina];
}

class SelectUsuarioEvent extends UsuariosEvent {
  final int index;

  SelectUsuarioEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AddUsuarioRolEvent extends UsuariosEvent {
  final int usuario;
  final int rol;

  AddUsuarioRolEvent(this.usuario, this.rol);

  @override
  List<Object> get props => [usuario, rol];
}
