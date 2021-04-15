import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/login_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';

class UsuarioRepository implements IUsuarioRepository {
  final ILoginRemoteDataSource remoteDatasource;

  UsuarioRepository(this.remoteDatasource);

  @override
  Future<Either<IFailure, Pagina<List<Usuario>>>> getUsuarios(
      Pagina pagina) async {
    Pagina<List<Usuario>> result;
    try {
      result = await remoteDatasource.getUsuariosList(pagina);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la lista de usuarios"));
    }
  }

  @override
  Future<Either<IFailure, Pagina<List<Rol>>>> getRoles(Pagina pagina) async {
    Pagina<List<Rol>> result;
    try {
      result = await remoteDatasource.getRolesList(pagina);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la lista de roles"));
    }
  }

  @override
  Future<Either<IFailure, List<Sistema>>> getSistemas() async {
    List<Sistema> result;
    try {
      result = await remoteDatasource.getSistemasList();
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(
            ServerFailure(message: "No se pudo obtener la lista de sistemas"));
      }
    }
  }

  @override
  Future<Either<IFailure, List<Permiso>>> getPermisos(String consulta) async {
    List<Permiso> result;
    try {
      result = await remoteDatasource.getPermisosList(consulta);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(
            ServerFailure(message: "No se pudo obtener la lista de permisos"));
      }
    }
  }
}
