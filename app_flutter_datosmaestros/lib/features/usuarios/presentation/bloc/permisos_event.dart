part of 'permisos_bloc.dart';

@immutable
abstract class PermisosEvent extends Equatable {
  const PermisosEvent();
}

class GetPermisosEvent extends PermisosEvent {
  final String consulta;

  GetPermisosEvent(this.consulta);
  @override
  List<Object> get props => [consulta];
}
