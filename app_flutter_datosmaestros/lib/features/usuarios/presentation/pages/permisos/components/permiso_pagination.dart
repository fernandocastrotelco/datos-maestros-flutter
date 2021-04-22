import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:flutter/material.dart';

class PermisoPagination extends StatelessWidget {
  const PermisoPagination({
    Key key,
    @required PermisosBloc bloc,
    Pagina pagina,
  })  : _bloc = bloc,
        _pagina = pagina,
        super(key: key);

  final PermisosBloc _bloc;
  final Pagina _pagina;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5),
        Text(
          "Permisos",
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
            _bloc.add(GetPermisosPagedEvent(primeraPagina));
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
              _bloc.add(GetPermisosPagedEvent(anteriorPagina));
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
              _bloc.add(GetPermisosPagedEvent(siguientePagina));
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
              _bloc.add(GetPermisosPagedEvent(ultimaPagina));
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
