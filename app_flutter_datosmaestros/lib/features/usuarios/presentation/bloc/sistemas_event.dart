part of 'sistemas_bloc.dart';

@immutable
abstract class SistemasEvent extends Equatable {}

class GetSistemasEvent extends SistemasEvent {
  final Pagina pagina;

  GetSistemasEvent(this.pagina);

  @override
  List<Object> get props => [pagina];
}

class SelectSistemaEvent extends SistemasEvent {
  final int index;

  SelectSistemaEvent(this.index);

  @override
  List<Object> get props => [index];
}

class CrudSistemaEvent extends SistemasEvent {
  final Crud crud;

  CrudSistemaEvent(this.crud);

  @override
  List<Object> get props => [crud];
}

class AddRolEvent extends SistemasEvent {
  final int sistema;
  final int rol;

  AddRolEvent(this.sistema, this.rol);

  @override
  List<Object> get props => [sistema, rol];
}

class SubmitSistemaEvent extends SistemasEvent {
  final int id;
  final String sistema;
  final int activo;

  SubmitSistemaEvent({this.id, this.sistema, this.activo});

  @override
  List<Object> get props => [id, sistema, activo];
}
