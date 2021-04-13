import 'package:app_flutter_datosmaestros/features/usuarios/data/models/rol_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';

class SistemaModel extends Sistema {
  SistemaModel({
    int id,
    String sistema,
    int activo,
    String createdAt,
    String updatedAt,
    List<Rol> roles,
  }) : super(
          id: id,
          sistema: sistema,
          activo: activo,
          createdAt: createdAt,
          updatedAt: updatedAt,
          roles: roles,
        );
  factory SistemaModel.fromMap(Map<String, dynamic> obj) {
    var rolesObj = obj['roles'] as List;
    List<Rol> rolesList = <Rol>[];
    if (rolesObj?.isNotEmpty ?? false) {
      rolesList = rolesObj.map((e) => RolModel.fromMap(e)).toList();
    }
    // final rolesObj =
    //     List<Rol>.from(obj["roles"].map((x) => RolModel.fromMap(x)));

    final sist = SistemaModel(
      id: obj['id'],
      sistema: obj['sistema'] ?? 'Sistema pruebas',
      activo: obj['activo'] ?? 0,
      createdAt: obj['createdAt'] ?? '2021-03-01',
      updatedAt: obj['updatedAt'] ?? '2021-03-01',
      roles: rolesList,
    );
    return sist;
  }
}
