import 'package:equatable/equatable.dart';

class Permiso extends Equatable {
  Permiso(
      {this.id,
      this.permiso,
      this.scope,
      this.descripcion,
      this.activo,
      this.createdAt,
      this.updatedAt});

  final int id;
  final String permiso;
  final String scope;
  final String descripcion;
  final int activo;
  final String createdAt;
  final String updatedAt;

  @override
  List<Object> get props => [
        id,
        permiso,
        scope,
        descripcion,
        activo,
        createdAt,
        updatedAt,
      ];
}
