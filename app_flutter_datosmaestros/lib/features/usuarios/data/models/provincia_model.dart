import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';

class ProvinciaModel extends Provincia {
  ProvinciaModel({
    int id,
    String provincia,
    int paissId,
  }) : super(id: id, provincia: provincia, paissId: paissId);

  factory ProvinciaModel.fromMap(Map<String, dynamic> json) => ProvinciaModel(
        id: json["id"],
        provincia: json["provincia"],
        paissId: json["paiss_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "provincia": provincia,
        "paiss_id": paissId,
      };
}
