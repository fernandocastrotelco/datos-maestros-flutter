import 'package:app_flutter_datosmaestros/features/usuarios/data/models/permiso_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';

class RolModel extends Rol {
  RolModel({
    int id,
    String createdAt,
    String updatedAt,
    String rol,
    String scope,
    String descripcion,
    int activo,
    int sistemasId,
    List<Permiso> permisos,
  }) : super(
            id: id,
            rol: rol,
            scope: scope,
            descripcion: descripcion,
            activo: activo,
            sistemasId: sistemasId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            permisos: permisos);
  factory RolModel.fromMap(Map<String, dynamic> json) {
    return RolModel(
      id: json["id"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      rol: json["rol"],
      scope: json["scope"],
      descripcion: json["descripcion"],
      activo: json["activo"],
      sistemasId: json["sistemas_id"],
      permisos: json["permisos"] == null
          ? null
          : List<Permiso>.from(
              json["permisos"].map((x) => PermisoModel.fromMap(x))),
    );
  }
}
