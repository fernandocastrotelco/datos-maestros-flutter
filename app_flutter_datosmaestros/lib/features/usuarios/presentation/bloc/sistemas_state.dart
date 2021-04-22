part of 'sistemas_bloc.dart';

@immutable
abstract class SistemasState extends Equatable {}

class SistemasInitial extends SistemasState {
  @override
  List<Object> get props => [];
}

class SistemasLoadingState extends SistemasState {
  @override
  List<Object> get props => [];
}

class SistemasSuccessState extends SistemasState {
  final List<Sistema> sistemas;
  final Sistema seleccionado;
  final Pagina pagina;
  static const Sistema sistemaVacio = Sistema();
  SistemasSuccessState(this.sistemas, this.pagina,
      {this.seleccionado = sistemaVacio});

  SistemasSuccessState copyWith({
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
    return SistemasSuccessState(sistemas, nuevapagina,
        seleccionado: seleccionado);
  }

  @override
  List<Object> get props => [sistemas, seleccionado, pagina];
}

class SistemasCrudState extends SistemasState {
  final Sistema sistema;

  SistemasCrudState(this.sistema);
  @override
  List<Object> get props => [sistema];
}

class SistemasErrorState extends SistemasState {
  final String mensaje;

  SistemasErrorState(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}
