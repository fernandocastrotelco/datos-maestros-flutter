part of 'sistema_form_cubit.dart';

class SistemaFormState {
  final int id;
  final String sistema;
  final bool activo;

  SistemaFormState({this.id = 0, this.sistema, this.activo = true});

  SistemaFormState copyWith({
    int id,
    String sistema,
    bool activo,
  }) {
    return SistemaFormState(
      id: id ?? this.id,
      sistema: sistema ?? this.sistema,
      activo: activo ?? this.activo,
    );
  }
}
