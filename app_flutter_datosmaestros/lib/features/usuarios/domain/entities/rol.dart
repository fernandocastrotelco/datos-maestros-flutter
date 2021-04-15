import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:equatable/equatable.dart';

class Rol extends Equatable {
  const Rol(
      {this.id,
      this.sistemasId,
      this.rol,
      this.scope,
      this.descripcion,
      this.activo,
      this.createdAt,
      this.updatedAt,
      this.permisos});
  final int id;
  final int sistemasId;
  final String rol;
  final String scope;
  final String descripcion;
  final int activo;
  final String createdAt;
  final String updatedAt;
  final List<Permiso> permisos;
  @override
  List<Object> get props => [
        id,
        sistemasId,
        rol,
        scope,
        descripcion,
        activo,
        createdAt,
        updatedAt,
        permisos,
      ];
}
