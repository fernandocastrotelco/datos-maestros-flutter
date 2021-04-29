import 'package:app_flutter_datosmaestros/constants.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/localidad_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/persona_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/data/models/provincia_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/infra/http/http_client.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

abstract class IPersonaRemoteDatasource {
  Future<List<Provincia>> getProvinciaList();
  Future<List<Localidad>> getLocalidadList(int provincia);
  Future<Persona> getPersona(Map<String, String> params);
  Future<Persona> postPersona(PersonaModel persona);
}

class PersonaRemoteDatasource implements IPersonaRemoteDatasource {
  final HttpClient client;

  PersonaRemoteDatasource(this.client);

  @override
  Future<List<Localidad>> getLocalidadList(int provincia) async {
    var result = <Localidad>[];
    final paramsApi = {"provincia": '$provincia'};
    try {
      final url = Uri.http(DATOSMAESTROS, '/ubicacion/localidades', paramsApi);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final localidades = response['data'];
        localidades.forEach((localidad) {
          result.add(LocalidadModel.fromMap(localidad));
        });
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      throw ServerFailure(message: "Error inesperado al consultar localidades");
    }
  }

  @override
  Future<Persona> getPersona(Map<String, String> params) async {
    try {
      final url = Uri.http(DATOSMAESTROS, '/personas/cuil', params);

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final personaMap = response['data'];
        return PersonaModel.fromMap(personaMap);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
    } catch (e) {
      throw ServerFailure(message: "Error inesperado al consultar persona");
    }
  }

  @override
  Future<List<Provincia>> getProvinciaList() async {
    var result = <Provincia>[];
    try {
      final url = Uri.http(DATOSMAESTROS, '/ubicacion/provincias');

      final response = await client.request(url: url, method: "get");

      if (response['status']) {
        final provincias = response['data'];
        provincias.forEach((provincia) {
          result.add(ProvinciaModel.fromMap(provincia));
        });
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
      return result;
    } catch (e) {
      throw ServerFailure(message: "Error inesperado al consultar provincias");
    }
  }

  @override
  Future<Persona> postPersona(PersonaModel persona) async {
    try {
      final url = Uri.http(DATOSMAESTROS, 'personas/');

      final response =
          await client.request(url: url, method: 'post', body: persona.toMap());

      if (response['status']) {
        final personaMap = response['data'];
        return PersonaModel.fromMap(personaMap);
      } else {
        throw ServerFailure(message: response['message'].toString());
      }
    } catch (e) {
      throw ServerFailure(message: "Error inesperado al enviar persona");
    }
  }
}
