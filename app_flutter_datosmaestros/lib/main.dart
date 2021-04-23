import 'package:app_flutter_datosmaestros/dependencies.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/sistemas_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/permisos/permisos_principal_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/roles/roles_form_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/sistemas_form_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/sistemas/sistemas_principal_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/pages/usuarios/cubit/usuario_sistema_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/usuarios/domain/entities/pagina.dart';
import 'features/usuarios/presentation/pages/roles/roles_principal_page.dart';
import 'features/usuarios/presentation/pages/usuarios/principal_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UsuariosBloc>(
              create: (context) => UsuariosBloc(context.read(), context.read())
                ..add(GetUsuariosEvent(Pagina(numero: 1, tamanio: 5)))),
          BlocProvider<UsuarioSistemaCubit>(
            create: (context) => UsuarioSistemaCubit(context.read())..init(),
          ),
          BlocProvider<RolesBloc>(
              create: (context) => RolesBloc(context.read(), context.read(),
                  context.read(), context.read())
                ..add(GetRolesEvent(Pagina(numero: 1, tamanio: 5)))),
          BlocProvider<PermisosBloc>(
              create: (context) => PermisosBloc(context.read(), context.read(),
                  context.read(), context.read())),
          BlocProvider<SistemasBloc>(
              create: (context) =>
                  SistemasBloc(context.read(), context.read(), context.read())),
        ],
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
          initialRoute: '/home',
          routes: {
            '/home': (BuildContext context) => PrincipalPage(),
            '/sistemas': (BuildContext context) => SistemasPrincipalPage(),
            '/sistemas/edit': (BuildContext context) => SistemasFormPage(),
            '/roles': (BuildContext context) => RolesPrincipalPage(),
            '/roles/edit': (BuildContext context) => RolesFormPage(),
            '/permisos': (BuildContext context) => PermisosPrincipalPage(),
          },
          home: PrincipalPage(),
        ),
      ),
    );
  }
}
