part of 'usuario_nuevo_cubit.dart';

@immutable
class UsuarioNuevoState extends Equatable {
  final int id;
  final String nombre;
  final String apellido;
  final String documento;
  final String documentoError;
  final String sexo;
  final String sexoError;
  final int localidadId;
  final String calle;
  final String numero;
  final String telefono;
  final String correo;
  final String correoError;
  final String password;
  final String passwordError;
  final String confirm;
  final int index;
  final List<Provincia> provincias;
  final Provincia provincia;
  final List<Localidad> localidades;
  final Localidad localidad;

  UsuarioNuevoState(
      {this.id,
      this.nombre,
      this.apellido,
      this.documento,
      this.documentoError,
      this.sexo,
      this.sexoError,
      this.localidadId,
      this.calle,
      this.numero,
      this.telefono,
      this.correo,
      this.correoError,
      this.password,
      this.passwordError,
      this.confirm,
      this.index: 0,
      this.provincias,
      this.provincia,
      this.localidades,
      this.localidad});

  UsuarioNuevoState copyWith({
    int id,
    String nombre,
    String apellido,
    String documento,
    String documentoError,
    String sexo,
    String sexoError,
    int localidadId,
    String calle,
    String numero,
    String telefono,
    String correo,
    String correoError,
    String password,
    String passwordError,
    String confirm,
    int index,
    List<Provincia> provincias,
    Provincia provincia,
    List<Localidad> localidades,
    Localidad localidad,
  }) {
    return UsuarioNuevoState(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      documento: documento ?? this.documento,
      documentoError: documentoError ?? this.documentoError,
      sexo: sexo ?? this.sexo,
      sexoError: sexoError ?? this.sexoError,
      localidadId: localidadId ?? this.localidadId,
      calle: calle ?? this.calle,
      numero: numero ?? this.numero,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      correoError: correoError ?? this.correoError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      confirm: confirm ?? this.confirm,
      index: index ?? this.index,
      provincias: provincias ?? this.provincias,
      provincia: provincia ?? this.provincia,
      localidades: localidades ?? this.localidades,
      localidad: localidad ?? this.localidad,
    );
  }

  @override
  List<Object> get props => [
        id,
        nombre,
        apellido,
        documento,
        documentoError,
        sexo,
        sexoError,
        localidadId,
        calle,
        numero,
        telefono,
        correo,
        correoError,
        password,
        passwordError,
        confirm,
        index,
        provincias,
        provincia,
        localidades,
        localidad
      ];
}
