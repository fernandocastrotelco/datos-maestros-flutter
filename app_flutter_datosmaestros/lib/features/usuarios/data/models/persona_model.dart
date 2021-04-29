import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/persona.dart';

class PersonaModel extends Persona {
  PersonaModel(
      {int personaId,
      String nombre,
      String apellido,
      String cuil,
      String documento,
      String sexo,
      DateTime fechaNacimiento,
      String tipo,
      int provinciaId,
      String provincia,
      int localidadId,
      String localidad,
      String direccion,
      String telefono,
      String correo})
      : super(
            personaId: personaId,
            nombre: nombre,
            apellido: apellido,
            cuil: cuil,
            documento: documento,
            sexo: sexo,
            fechaNacimiento: fechaNacimiento,
            tipo: tipo,
            provinciaId: provinciaId,
            provincia: provincia,
            localidadId: localidadId,
            localidad: localidad,
            direccion: direccion,
            telefono: telefono,
            correo: correo);

  factory PersonaModel.fromMap(Map<String, dynamic> json) => PersonaModel(
        personaId: json["persona_id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        cuil: json["cuil"],
        documento: json["documento"],
        sexo: json["sexo"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        tipo: json["tipo"],
        provinciaId: json["provincia_id"],
        provincia: json["provincia"],
        localidadId: json["localidad_id"],
        localidad: json["localidad"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        correo: json["correo"],
      );

  Map<String, dynamic> toMap() => {
        "persona_id": personaId,
        "nombre": nombre,
        "apellido": apellido,
        "cuil": cuil,
        "documento": documento,
        "sexo": sexo,
        "fecha_nacimiento": fechaNacimiento.toIso8601String(),
        "tipo": tipo,
        "provincia_id": provinciaId,
        "provincia": provincia,
        "localidad_id": localidadId,
        "localidad": localidad,
        "direccion": direccion,
        "telefono": telefono,
        "correo": correo,
      };
}
