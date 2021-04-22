import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:flutter/material.dart';

class SistemasPagination extends StatelessWidget {
  const SistemasPagination({
    Key key,
    @required SistemasBloc bloc,
    Pagina pagina,
  })  : _bloc = bloc,
        _pagina = pagina,
        super(key: key);

  final SistemasBloc _bloc;
  final Pagina _pagina;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        Text(
          "Sistemas",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Spacer(),
        MaterialButton(
          minWidth: 20,
          onPressed: () {
            final primeraPagina = Pagina(
              numero: 1,
              tamanio: _pagina.tamanio,
              total: _pagina.total,
              registros: _pagina.registros,
              consulta: _pagina.consulta,
              data: _pagina.data,
            );
            _bloc.add(GetSistemasEvent(primeraPagina));
          },
          child: Icon(
            Icons.first_page_rounded,
            size: 18,
          ),
        ),
        MaterialButton(
          minWidth: 20,
          onPressed: () {
            if (_pagina.numero > 1) {
              final anteriorPagina = Pagina(
                numero: _pagina.numero - 1,
                tamanio: _pagina.tamanio,
                total: _pagina.total,
                registros: _pagina.registros,
                consulta: _pagina.consulta,
                data: _pagina.data,
              );
              _bloc.add(GetSistemasEvent(anteriorPagina));
            }
          },
          child: Icon(
            Icons.chevron_left_rounded,
            size: 18,
          ),
        ),
        Text('${_pagina.numero} / ${_pagina.total}'),
        MaterialButton(
          minWidth: 20,
          onPressed: () {
            if (_pagina.numero < _pagina.total) {
              final siguientePagina = Pagina(
                numero: _pagina.numero + 1,
                tamanio: _pagina.tamanio,
                total: _pagina.total,
                registros: _pagina.registros,
                consulta: _pagina.consulta,
                data: _pagina.data,
              );
              _bloc.add(GetSistemasEvent(siguientePagina));
            }
          },
          child: Icon(
            Icons.chevron_right_rounded,
            size: 18,
          ),
        ),
        MaterialButton(
          minWidth: 20,
          onPressed: () {
            if (_pagina.numero < _pagina.total) {
              final ultimaPagina = Pagina(
                numero: _pagina.total,
                tamanio: _pagina.tamanio,
                total: _pagina.total,
                registros: _pagina.registros,
                consulta: _pagina.consulta,
                data: _pagina.data,
              );
              _bloc.add(GetSistemasEvent(ultimaPagina));
            }
          },
          child: Icon(
            Icons.last_page_rounded,
            size: 18,
          ),
        ),
      ],
    );
  }
}
