import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/widgets/usuario_card.dart';
import 'package:app_flutter_datosmaestros/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfUsuarios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<UsuariosBloc>();
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgDarkColor,
      child: SafeArea(
          right: false,
          child: BlocBuilder<UsuariosBloc, UsuariosState>(
              builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {},
                        ),
                      if (!Responsive.isDesktop(context))
                        SizedBox(
                          width: 5,
                        ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (state is UsuariosSuccessState) {
                              Pagina pagina = Pagina(
                                  numero: state.pagina.numero,
                                  tamanio: state.pagina.tamanio,
                                  consulta: value);
                              _bloc.add(GetUsuariosEvent(pagina));
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Buscar",
                            fillColor: kBgLightColor,
                            filled: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(
                                  kDefaultPadding * 0.75), //15
                              child: Icon(
                                Icons.search,
                                size: 24,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: BlocBuilder<UsuariosBloc, UsuariosState>(
                      builder: (context, state) {
                    if (state is UsuariosSuccessState) {
                      return Row(
                        children: [
                          SizedBox(width: 5),
                          Text(
                            "Usuarios",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Spacer(),
                          MaterialButton(
                            minWidth: 20,
                            onPressed: () {
                              final primeraPagina = Pagina(
                                numero: 1,
                                tamanio: state.pagina.tamanio,
                                total: state.pagina.total,
                                registros: state.pagina.registros,
                                consulta: state.pagina.consulta,
                                data: state.pagina.data,
                              );
                              _bloc.add(GetUsuariosEvent(primeraPagina));
                            },
                            child: Icon(
                              Icons.first_page_rounded,
                              size: 18,
                            ),
                          ),
                          MaterialButton(
                            minWidth: 20,
                            onPressed: () {
                              if (state.pagina.numero > 1) {
                                final anteriorPagina = Pagina(
                                  numero: state.pagina.numero - 1,
                                  tamanio: state.pagina.tamanio,
                                  total: state.pagina.total,
                                  registros: state.pagina.registros,
                                  consulta: state.pagina.consulta,
                                  data: state.pagina.data,
                                );
                                _bloc.add(GetUsuariosEvent(anteriorPagina));
                              }
                            },
                            child: Icon(
                              Icons.chevron_left_rounded,
                              size: 18,
                            ),
                          ),
                          Text(
                              '${state.pagina.numero} / ${state.pagina.total}'),
                          MaterialButton(
                            minWidth: 20,
                            onPressed: () {
                              if (state.pagina.numero < state.pagina.total) {
                                final siguientePagina = Pagina(
                                  numero: state.pagina.numero + 1,
                                  tamanio: state.pagina.tamanio,
                                  total: state.pagina.total,
                                  registros: state.pagina.registros,
                                  consulta: state.pagina.consulta,
                                  data: state.pagina.data,
                                );
                                _bloc.add(GetUsuariosEvent(siguientePagina));
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
                              if (state.pagina.numero < state.pagina.total) {
                                final ultimaPagina = Pagina(
                                  numero: state.pagina.total,
                                  tamanio: state.pagina.tamanio,
                                  total: state.pagina.total,
                                  registros: state.pagina.registros,
                                  consulta: state.pagina.consulta,
                                  data: state.pagina.data,
                                );
                                _bloc.add(GetUsuariosEvent(ultimaPagina));
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Expanded(
                  child: BlocBuilder<UsuariosBloc, UsuariosState>(
                      builder: (context, state) {
                    if (state is UsuariosSuccessState) {
                      return ListView.builder(
                          itemCount: state.usuarios.length,
                          itemBuilder: (context, index) => UsuarioCard(
                              isActive: Responsive.isMobile(context)
                                  ? false
                                  : state.usuarios[index].id ==
                                      state.seleccionado.id,
                              usuario: state.usuarios[index],
                              press: () {
                                _bloc.add(SelectUsuarioEvent(index));
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => DetallePage(
                                //           usuario: state.usuarios[index]),
                                //     ));
                              }));
                    }
                    if (state is UsuariosLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                )
              ],
            );
          })),
    ));
  }
}
