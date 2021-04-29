import 'package:equatable/equatable.dart';

class Localidad extends Equatable {
  Localidad({this.id, this.localidad, this.departamento});
  final int id;
  final String localidad;
  final String departamento;

  @override
  List<Object> get props => [id, localidad, departamento];
}
