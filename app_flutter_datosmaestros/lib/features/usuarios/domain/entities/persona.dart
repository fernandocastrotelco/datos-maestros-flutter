import 'package:equatable/equatable.dart';

class Persona extends Equatable {
  Persona(
      {this.personaId,
      this.nombre,
      this.apellido,
      this.cuil,
      this.documento,
      this.sexo,
      this.fechaNacimiento,
      this.tipo,
      this.provinciaId,
      this.provincia,
      this.localidadId,
      this.localidad,
      this.direccion,
      this.telefono,
      this.correo});

  final int personaId;
  final String nombre;
  final String apellido;
  final String cuil;
  final String documento;
  final String sexo;
  final DateTime fechaNacimiento;
  final String tipo;
  final int provinciaId;
  final String provincia;
  final int localidadId;
  final String localidad;
  final String direccion;
  final String telefono;
  final String correo;

  @override
  List<Object> get props => [
        personaId,
        nombre,
        apellido,
        cuil,
        documento,
        sexo,
        fechaNacimiento,
        tipo,
        provinciaId,
        provincia,
        localidadId,
        localidad,
        direccion,
        telefono,
        correo,
      ];
}
