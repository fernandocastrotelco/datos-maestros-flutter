import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';

class PermisoModel extends Permiso {
  PermisoModel({
    int id,
    String createdAt,
    String updatedAt,
    String permiso,
    String scope,
    String descripcion,
    int activo,
  }) : super(
            id: id,
            permiso: permiso,
            scope: scope,
            descripcion: descripcion,
            activo: activo,
            createdAt: createdAt,
            updatedAt: updatedAt);
  factory PermisoModel.fromMap(Map<String, dynamic> json) {
    return PermisoModel(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        permiso: json["permiso"],
        scope: json["scope"],
        descripcion: json["descripcion"],
        activo: json["activo"]);
  }
}
