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
  Future<Either<IFailure, List<Permiso>>> getPermisos(int rolId) async {
    List<Permiso> result;
    try {
      result = await remoteDatasource.getPermisosList(rolId);
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

  @override
  Future<Either<IFailure, Rol>> postRol(Rol rol) async {
    Rol result;
    try {
      result = await remoteDatasource.postRol(rol);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo guardar rol"));
      }
    }
  }

  @override
  Future<Either<IFailure, bool>> deleteRol(int id) async {
    try {
      final result = await remoteDatasource.deleteRol(id);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo eliminar el rol"));
      }
    }
  }

  @override
  Future<Either<IFailure, bool>> addPermiso(int idRol, int idPermiso) async {
    try {
      final result = await remoteDatasource.putPermisoToRol(idRol, idPermiso);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo agregar el permiso"));
      }
    }
  }

  @override
  Future<Either<IFailure, bool>> deletePermiso(int id) async {
    try {
      final result = await remoteDatasource.deletePermiso(id);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo eliminar el permiso"));
      }
    }
  }

  @override
  Future<Either<IFailure, Pagina<List<Permiso>>>> getPermisoPage(
      Pagina pagina) async {
    Pagina<List<Permiso>> result;
    try {
      result = await remoteDatasource.getPermisosPage(pagina);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(message: "No se pudo obtener la página de permisos"));
    }
  }

  @override
  Future<Either<IFailure, Permiso>> postPermiso(Permiso permiso) async {
    Permiso result;
    try {
      result = await remoteDatasource.postPermiso(permiso);
      return Right(result);
    } catch (e) {
      if (e is ServerFailure) {
        return Left(e);
      } else {
        return Left(ServerFailure(message: "No se pudo guardar el permiso"));
      }
    }
  }
}
