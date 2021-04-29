import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/persona_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/ipersona_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

class PersonaRepository implements IPersonaRepository {
  final IPersonaRemoteDatasource datasource;

  PersonaRepository(this.datasource);

  @override
  Future<Either<IFailure, List<Localidad>>> getLocalidades(
      int provincia) async {
    try {
      final result = await datasource.getLocalidadList(provincia);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la lista de localidades"));
    }
  }

  @override
  Future<Either<IFailure, Persona>> getPersona(
      Map<String, String> params) async {
    try {
      final result = await datasource.getPersona(params);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: "No se pudo obtener la persona"));
    }
  }

  @override
  Future<Either<IFailure, List<Provincia>>> getProvincias() async {
    try {
      final result = await datasource.getProvinciaList();
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la lista de provincias"));
    }
  }
}
