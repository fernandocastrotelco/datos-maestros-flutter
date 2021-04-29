import 'package:equatable/equatable.dart';

class Provincia extends Equatable {
  Provincia({this.id, this.provincia, this.paissId});
  final int id;
  final String provincia;
  final int paissId;

  @override
  List<Object> get props => [id, provincia, paissId];
}
