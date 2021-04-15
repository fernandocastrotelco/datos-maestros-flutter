import 'package:equatable/equatable.dart';

class Pagina<T> extends Equatable {
  final int numero;
  final int tamanio;
  final int total;
  final int registros;
  final String consulta;
  final T data;

  Pagina(
      {this.numero,
      this.tamanio,
      this.total,
      this.registros,
      this.consulta,
      this.data});

  factory Pagina.fromMap(Map<String, dynamic> obj) {
    return Pagina(
      numero: obj['pagina'],
      tamanio: obj['tamanio'],
      total: obj['total_paginas'],
      registros: obj['registros'],
      consulta: obj['qwery'],
      data: obj['data'],
    );
  }

  @override
  List<Object> get props => [numero, tamanio, total, registros, consulta, data];
}
