import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/login_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/repositories/usuario_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_roles.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_usuarios.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/permisos_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/roles_bloc.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/presentation/bloc/usuarios_bloc.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'infra/http/http_adapter.dart';

List<RepositoryProvider> buildRepositories() {
  final HttpClient client = HttpAdapter(http.Client());
  return [
    RepositoryProvider<ILoginRemoteDataSource>(
        create: (_) => LoginRemoteDataSource(client)),
    RepositoryProvider<IUsuarioRepository>(
        create: (context) => UsuarioRepository(context.read())),
    RepositoryProvider<GetUsuarios>(
        create: (context) => GetUsuarios(context.read())),
    RepositoryProvider<GetRoles>(
      create: (context) => GetRoles(context.read()),
    ),
    RepositoryProvider<GetSistemas>(
        create: (context) => GetSistemas(context.read())),
    RepositoryProvider<GetPermisos>(
        create: (context) => GetPermisos(context.read())),
    RepositoryProvider<UsuariosBloc>(
        create: (context) => UsuariosBloc(context.read())),
    RepositoryProvider<RolesBloc>(
        create: (context) => RolesBloc(context.read(), context.read())),
    RepositoryProvider(create: (context) => PermisosBloc(context.read())),
  ];
}
