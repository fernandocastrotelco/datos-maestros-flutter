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
  Future<List<Permiso>> getPermisosList(String consulta);
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
  Future<List<Permiso>> getPermisosList(String consulta) async {
    var result = <Permiso>[];
    try {
      final paramsApi = {"consulta": consulta};
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
}
