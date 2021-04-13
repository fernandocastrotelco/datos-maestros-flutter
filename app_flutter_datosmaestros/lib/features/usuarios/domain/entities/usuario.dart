import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  const Usuario({
    this.id,
    this.user,
    this.nombre,
    this.password,
    this.personasId,
    this.activo,
    this.createdAt,
    this.updatedAt,
    this.sistemas,
  });
  final int id;
  final String user;
  final String nombre;
  final String password;
  final int personasId;
  final int activo;
  final String createdAt;
  final String updatedAt;
  final List<Sistema> sistemas;

  @override
  List<Object> get props => [
        id,
        user,
        nombre,
        password,
        personasId,
        activo,
        createdAt,
        updatedAt,
        sistemas,
      ];
}
