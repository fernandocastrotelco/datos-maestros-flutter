import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/sistema_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

abstract class ISistemaRemoteDataSource {
  Future<Pagina<List<Sistema>>> getSistemasPage(Pagina params);
  Future<Sistema> postSistema(Sistema sistema);
  Future<bool> putRolToSistema(int idSistema, int idRol);
  Future<bool> putRolToUsuario(int idUsuario, int idRol);
}

class SistemaRemoteDataSource implements ISistemaRemoteDataSource {
  final HttpClient client;

  SistemaRemoteDataSource(this.client);

  @override
  Future<Pagina<List<Sistema>>> getSistemasPage(Pagina params) async {
    var result = <Sistema>[];
    Pagina<List<Sistema>> pagina;
    final paramsApi = {
      "pagina": params.numero.toString(),
      "tamanio": params.tamanio.toString(),
      "consulta": params.consulta
    };

    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/sistemas', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final sistemas = response['data'];
        sistemas.forEach((sistema) {
          result.add(SistemaModel.fromMap(sistema));
        });
        final pagina1 = Pagina.fromMap(response['pagina']);
        pagina = Pagina<List<Sistema>>(
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
      throw ServerFailure(message: "Error inesperado al consultar Sistemas");
    }
  }

  @override
  Future<Sistema> postSistema(Sistema sistema) async {
    Sistema result;
    try {
      final paramsApi = {
        "id": sistema.id,
        "sistema": sistema.sistema,
        "activo": sistema.activo,
      };
      final url = Uri.http(DATOSMAESTROS, '/usuarios/sistemas');

      final response =
          await client.request(url: url, method: 'post', body: paramsApi);
      if (response['status']) {
        result = SistemaModel.fromMap(response['data']);
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
  Future<bool> putRolToSistema(int idSistema, int idRol) async {
    bool result;
    try {
      final paramsApi = {
        "sistema": '$idSistema',
        "rol": '$idRol',
      };

      final url = Uri.http(DATOSMAESTROS, '/usuarios/roles', paramsApi);

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
  Future<bool> putRolToUsuario(int idUsuario, int idRol) async {
    bool result;
    try {
      final url = Uri.http(DATOSMAESTROS, '/usuarios/$idUsuario/rol/$idRol');

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
}
