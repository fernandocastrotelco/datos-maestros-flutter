import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/login_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/sistema_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/persona_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/repositories/persona_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/repositories/sistema_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/repositories/usuario_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/ipersona_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/add_usuario_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/create_usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/delete_usuario_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_localidades.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_permisos_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_provincias.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_roles.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas_page.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_usuarios.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/post_rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/post_sistema.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/usuarios/domain/usecases/post_permiso.dart';
import 'infra/http/http_adapter.dart';

List<RepositoryProvider> buildRepositories() {
  final HttpClient client = HttpAdapter(http.Client());
  return [
    //Data Sources
    RepositoryProvider<ILoginRemoteDataSource>(
        create: (_) => LoginRemoteDataSource(client)),
    RepositoryProvider<ISistemaRemoteDataSource>(
      create: (_) => SistemaRemoteDataSource(client),
    ),
    RepositoryProvider<IPersonaRemoteDatasource>(
      create: (_) => PersonaRemoteDatasource(client),
    ),

    //Repositories
    RepositoryProvider<IUsuarioRepository>(
        create: (context) => UsuarioRepository(context.read())),
    RepositoryProvider<ISistemaRepository>(
      create: (context) => SistemaRepository(context.read()),
    ),
    RepositoryProvider<IPersonaRepository>(
      create: (context) => PersonaRepository(context.read()),
    ),

    //Use Cases
    RepositoryProvider<GetUsuarios>(
        create: (context) => GetUsuarios(context.read())),
    RepositoryProvider<GetRoles>(
      create: (context) => GetRoles(context.read()),
    ),
    RepositoryProvider<GetSistemas>(
        create: (context) => GetSistemas(context.read())),
    RepositoryProvider<GetPermisos>(
        create: (context) => GetPermisos(context.read())),
    RepositoryProvider<PostRol>(create: (context) => PostRol(context.read())),
    RepositoryProvider<DeleteRol>(
      create: (context) => DeleteRol(context.read()),
    ),
    RepositoryProvider<AddPermiso>(
      create: (context) => AddPermiso(context.read()),
    ),
    RepositoryProvider<GetPermisosPage>(
      create: (context) => GetPermisosPage(context.read()),
    ),
    RepositoryProvider<PostPermiso>(
      create: (context) => PostPermiso(context.read()),
    ),
    RepositoryProvider<DeletePermiso>(
      create: (context) => DeletePermiso(context.read()),
    ),
    RepositoryProvider<GetSistemasPage>(
      create: (context) => GetSistemasPage(context.read()),
    ),
    RepositoryProvider<PostSistema>(
      create: (context) => PostSistema(context.read()),
    ),
    RepositoryProvider<AddRol>(
      create: (context) => AddRol(context.read()),
    ),
    RepositoryProvider<AddUsuarioRol>(
      create: (context) => AddUsuarioRol(context.read()),
    ),
    RepositoryProvider<DeleteUsuarioRol>(
      create: (context) => DeleteUsuarioRol(context.read()),
    ),
    RepositoryProvider<GetProvincias>(
      create: (context) => GetProvincias(context.read()),
    ),
    RepositoryProvider<GetLocalidades>(
      create: (context) => GetLocalidades(context.read()),
    ),
    RepositoryProvider<GetPersona>(
      create: (context) => GetPersona(context.read()),
    ),
    RepositoryProvider<CreateUsuario>(
      create: (context) => CreateUsuario(context.read()),
    ),
  ];
}
