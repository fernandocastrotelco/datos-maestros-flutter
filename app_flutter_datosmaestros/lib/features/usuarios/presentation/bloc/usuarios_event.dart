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
