import 'package:app_flutter_datosmaestros/features/usuarios/data/models/usuario_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

abstract class ILoginRemoteDataSource {
  Future<Pagina<List<Usuario>>> getUsuariosList(Pagina params);
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
      final url = Uri.http('127.0.0.1:3395', '/usuarios', paramsApi);

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
}
