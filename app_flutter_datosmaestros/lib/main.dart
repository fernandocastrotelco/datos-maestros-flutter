import 'package:app_flutter_datosmaestros/dependencies.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/pages/principal_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/usuarios/domain/entities/pagina.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: BlocProvider<UsuariosBloc>(
        create: (context) => UsuariosBloc(context.read())
          ..add(GetUsuariosEvent(Pagina(numero: 1, tamanio: 5))),
        child: MaterialApp(
          title: 'Panel de Control',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
              primary: Colors.blueGrey,
            )),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Color(0xFF3D45EE),
              ),
            )),
            primarySwatch: Colors.blue,
          ),
          home: PrincipalPage(),
        ),
      ),
    );
  }
}
