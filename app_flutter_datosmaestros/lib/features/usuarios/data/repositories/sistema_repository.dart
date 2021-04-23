import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/sistema_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

class SistemaRepository implements ISistemaRepository {
  final ISistemaRemoteDataSource remoteDatasource;

  SistemaRepository(this.remoteDatasource);

  @override
  Future<Either<IFailure, Pagina<List<Sistema>>>> getSistemas(
      Pagina pagina) async {
    Pagina<List<Sistema>> result;
    try {
      result = await remoteDatasource.getSistemasPage(pagina);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la lista de sistemas"));
    }
  }

  @override
  Future<Either<IFailure, Sistema>> postSistema(Sistema sistema) async {
    Sistema result;
    try {
      result = await remoteDatasource.postSistema(sistema);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo guardar sistema"));
      }
    }
  }

  @override
  Future<Either<IFailure, bool>> addRol(int idSistema, int idRol) async {
    try {
      final result = await remoteDatasource.putRolToSistema(idSistema, idRol);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo agregar el rol"));
      }
    }
  }

  @override
  Future<Either<IFailure, bool>> addUsuarioRol(int idUsuario, int idRol) async {
    try {
      final result = await remoteDatasource.putRolToUsuario(idUsuario, idRol);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo agregar el rol"));
      }
    }
  }
}
