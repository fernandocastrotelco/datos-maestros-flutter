import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/permiso_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/rol_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/sistema_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/usuario_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

abstract class ILoginRemoteDataSource {
  Future<Pagina<List<Usuario>>> getUsuariosList(Pagina params);
  Future<Pagina<List<Rol>>> getRolesList(Pagina params);
  Future<List<Sistema>> getSistemasList();
  Future<List<Permiso>> getPermisosList(int rolId);
  Future<Rol> postRol(Rol rol);
  Future<bool> deleteRol(int id);
  Future<bool> putPermisoToRol(int idRol, int idPermiso);
  Future<Pagina<List<Permiso>>> getPermisosPage(Pagina params);
  Future<Permiso> postPermiso(Permiso permiso);
  Future<bool> deletePermiso(int id);
  Future<bool> quitarRolUsuario(int idUsuario, int idRol);
  Future<Usuario> crearUsuario(UsuarioModel usuario);
}

class LoginRemoteDataSource implements ILoginRemoteDataSource {
  final HttpClient client;

  LoginRemoteDataSource(this.client);

  @override
  Future<Pagina<List<Usuario>>> getUsuariosList(Pagina params) async {
    var result = <Usuario>[];
    Pagina<List<Usuario>> pagina;
    final paramsApi = {
      "pagina": params.numero.toString(),
      "tamanio": params.tamanio.toString(),
      "consulta": params.consulta
    };

    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final usuarios = response['data'];
        usuarios.forEach((usuario) {
          result.add(UsuarioModel.fromMap(usuario));
        });
        final pagina1 = Pagina.fromMap(response['page']);
        pagina = Pagina<List<Usuario>>(
            numero: pagina1.numero,
            tamanio: pagina1.tamanio,
            total: pagina1.total,
            registros: pagina1.registros,
            consulta: pagina1.consulta,
            data: result);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }

      return pagina;
    } catch (e) {
      print(e.toString());
      throw ServerFailure(message: "Error inesperado al consultar usuarios");
    }
  }

  @override
  Future<Pagina<List<Rol>>> getRolesList(Pagina params) async {
    var result = <Rol>[];
    Pagina<List<Rol>> pagina;
    final paramsApi = {
      "pagina": params.numero.toString(),
      "tamanio": params.tamanio.toString(),
      "consulta": params.consulta
    };

    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/roles', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final roles = response['data'];
        roles.forEach((rol) {
          result.add(RolModel.fromMap(rol));
        });
        final pagina1 = Pagina.fromMap(response['page']);
        pagina = Pagina<List<Rol>>(
            numero: pagina1.numero,
            tamanio: pagina1.tamanio,
            total: pagina1.total,
            registros: pagina1.registros,
            consulta: pagina1.consulta,
            data: result);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }

      return pagina;
    } catch (e) {
      print(e.toString());
      throw ServerFailure(message: "Error inesperado al consultar Roles");
    }
  }

  @override
  Future<List<Sistema>> getSistemasList() async {
    var sistemas = <Sistema>[];
    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/sistemas');

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final roles = response['data'];
        roles.forEach((sistema) {
          sistemas.add(SistemaModel.fromMap(sistema));
        });
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return sistemas;
    } catch (e) {
      print(e.toString());
      throw ServerFailure(message: "Error inesperado al consultar Sistemas");
    }
  }

  @override
  Future<List<Permiso>> getPermisosList(int rolId) async {
    var result = <Permiso>[];
    try {
      final paramsApi = {"rol": '$rolId'};
      final url = Uri.http(DATOSMAESTROS, '/usuarios/permisos', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final permisos = response['data'];
        permisos.forEach((permiso) {
          result.add(PermisoModel.fromMap(permiso));
        });
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      print(e.toString());
      throw ServerFailure(message: "Error inesperado al consultar permisos");
    }
  }

  @override
  Future<Rol> postRol(Rol rol) async {
    Rol result;
    try {
      final paramsApi = {
        "id": rol.id,
        "rol": rol.rol,
        "scope": rol.scope,
        "descripcion": rol.descripcion,
        "sistemas_id": rol.sistemasId,
        "activo": rol.activo,
      };
      final url = Uri.http(DATOSMAESTROS, '/usuarios/roles');

      final response =
          await client.request(url: url, method: 'post', body: paramsApi);
      if (response['status']) {
        result = RolModel.fromMap(response['data']);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<bool> deleteRol(int id) async {
    bool result;
    try {
      final paramsApi = {"rol": "$id"};

      final url = Uri.http(DATOSMAESTROS, '/usuarios/roles', paramsApi);

      final response = await client.request(url: url, method: 'delete');
      if (response['status']) {
        result = true;
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<bool> putPermisoToRol(int idRol, int idPermiso) async {
    bool result;
    try {
      final paramsApi = {
        "rol": '$idRol',
        "permiso": '$idPermiso',
      };

      final url = Uri.http(DATOSMAESTROS, '/usuarios/permisos', paramsApi);

      final response = await client.request(url: url, method: 'put');

      if (response['status']) {
        result = true;
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<Pagina<List<Permiso>>> getPermisosPage(Pagina params) async {
    var result = <Permiso>[];
    Pagina<List<Permiso>> pagina;
    final paramsApi = {
      "pagina": params.numero.toString(),
      "tamanio": params.tamanio.toString(),
      "consulta": params.consulta
    };

    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/permisos', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final permisos = response['data'];
        permisos.forEach((permiso) {
          result.add(PermisoModel.fromMap(permiso));
        });
        final pagina1 = Pagina.fromMap(response['pagina']);
        pagina = Pagina<List<Permiso>>(
            numero: pagina1.numero,
            tamanio: pagina1.tamanio,
            total: pagina1.total,
            registros: pagina1.registros,
            consulta: pagina1.consulta,
            data: result);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }

      return pagina;
    } catch (e) {
      print(e.toString());
      throw ServerFailure(message: "Error inesperado al consultar Permisos");
    }
  }

  @override
  Future<Permiso> postPermiso(Permiso permiso) async {
    Permiso result;
    try {
      final paramsApi = {
        "id": permiso.id,
        "permiso": permiso.permiso,
        "scope": permiso.scope,
        "descripcion": permiso.descripcion,
        "activo": permiso.activo,
      };
      final url = Uri.http(DATOSMAESTROS, '/usuarios/permisos');

      final response =
          await client.request(url: url, method: 'post', body: paramsApi);
      if (response['status']) {
        result = PermisoModel.fromMap(response['data']);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<bool> deletePermiso(int id) async {
    bool result;
    try {
      final paramsApi = {"permiso": "$id"};

      final url = Uri.http(DATOSMAESTROS, '/usuarios/permisos', paramsApi);

      final response = await client.request(url: url, method: 'delete');
      if (response['status']) {
        result = true;
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<bool> quitarRolUsuario(int idUsuario, int idRol) async {
    bool result;
    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/$idUsuario/rol/$idRol');

      final response = await client.request(url: url, method: 'delete');

      if (response['status']) {
        result = true;
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado");
      }
    }
  }

  @override
  Future<Usuario> crearUsuario(UsuarioModel usuario) async {
    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios');

      final response =
          await client.request(url: url, method: 'post', body: usuario.toMap());

      if (response['status']) {
        return UsuarioModel.fromMap(response['data']);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
    } catch (e) {
      if (e is ServerFailure) {
        throw e;
      } else {
        throw ServerFailure(message: "error inesperado al crear usuario");
      }
    }
  }
}
