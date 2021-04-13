import 'package:app_flutter_datosmaestros/features/usuarios/data/models/sistema_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  UsuarioModel({
    int id,
    String user,
    String nombre,
    String password,
    int personasId,
    int activo,
    String createdAt,
    String updatedAt,
    List<Sistema> sistemas,
  }) : super(
            id: id,
            user: user,
            nombre: nombre,
            password: password,
            personasId: personasId,
            activo: activo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sistemas: sistemas);
  factory UsuarioModel.fromMap(Map<String, dynamic> obj) {
    return UsuarioModel(
      id: obj['id'],
      user: obj['user'],
      nombre: obj['nombre'],
      password: obj['password'],
      personasId: obj['personas_id'],
      activo: obj['activo'],
      createdAt: obj['created_at'],
      updatedAt: obj['updated_at'],
      sistemas: List<Sistema>.from(
          obj["sistemas"].map((x) => SistemaModel.fromMap(x))),
    );
  }
}
