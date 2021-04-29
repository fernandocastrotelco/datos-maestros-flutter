import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';

class LocalidadModel extends Localidad {
  LocalidadModel({
    int id,
    String localidad,
    String departamento,
  }) : super(id: id, localidad: localidad, departamento: departamento);

  factory LocalidadModel.fromMap(Map<String, dynamic> json) => LocalidadModel(
        id: json["id"],
        localidad: json["localidad"],
        departamento: json["departamento"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "localidad": localidad,
        "departamento": departamento,
      };
}
