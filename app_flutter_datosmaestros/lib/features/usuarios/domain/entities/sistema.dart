import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:equatable/equatable.dart';

class Sistema extends Equatable {
  Sistema({
    this.id,
    this.sistema,
    this.activo,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  final int id;
  final String sistema;
  final int activo;
  final String createdAt;
  final String updatedAt;
  final List<Rol> roles;

  @override
  List<Object> get props => [
        id,
        sistema,
        activo,
        createdAt,
        updatedAt,
        roles,
      ];
}
