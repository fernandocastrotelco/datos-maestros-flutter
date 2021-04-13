part of 'usuarios_bloc.dart';

abstract class UsuariosState extends Equatable {
  const UsuariosState();
}

class UsuariosInitial extends UsuariosState {
  @override
  List<Object> get props => [];
}

class UsuariosLoadingState extends UsuariosState {
  @override
  List<Object> get props => [];
}

class UsuariosSuccessState extends UsuariosState {
  final List<Usuario> usuarios;
  final Usuario seleccionado;
  final Pagina pagina;
  static const Usuario usuarioVacio = Usuario();
  UsuariosSuccessState(this.usuarios, this.pagina,
      {this.seleccionado = usuarioVacio});

  UsuariosSuccessState copyWith({
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
    return UsuariosSuccessState(usuarios, nuevapagina,
        seleccionado: seleccionado);
  }

  @override
  List<Object> get props => [usuarios, seleccionado, pagina];
}

class UsuariosErrorState extends UsuariosState {
  final String mensaje;

  UsuariosErrorState(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}
