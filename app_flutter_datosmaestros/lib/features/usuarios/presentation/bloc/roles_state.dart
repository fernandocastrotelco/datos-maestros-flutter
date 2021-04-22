part of 'roles_bloc.dart';

@immutable
abstract class RolesState extends Equatable {}

class RolesInitial extends RolesState {
  @override
  List<Object> get props => [];
}

class RolesLoadingState extends RolesState {
  @override
  List<Object> get props => [];
}

class RolesSuccessState extends RolesState {
  final List<Rol> roles;
  final Rol seleccionado;
  final Pagina pagina;
  static const Rol rolVacio = Rol();
  RolesSuccessState(this.roles, this.pagina, {this.seleccionado = rolVacio});

  RolesSuccessState copyWith({
    int numero,
    int tamanio,
    String consulta,
  }) {
    final nuevapagina = Pagina(
      numero: numero ?? pagina.numero,
      tamanio: tamanio ?? pagina.tamanio,
      consulta: consulta ?? pagina.consulta,
      total: pagina.total,
      registros: pagina.registros,
      data: pagina.data,
    );
    return RolesSuccessState(roles, nuevapagina, seleccionado: seleccionado);
  }

  @override
  List<Object> get props => [roles, seleccionado, pagina];
}

class RolesCrudState extends RolesState {
  final Rol rol;

  RolesCrudState(this.rol);
  @override
  List<Object> get props => [rol];
}

class RolesErrorState extends RolesState {
  final String mensaje;

  RolesErrorState(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}
