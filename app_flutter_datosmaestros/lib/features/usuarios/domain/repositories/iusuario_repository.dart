import 'package:app_flutter_datosmaestros/features/usuarios/data/models/usuario_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:dartz/dartz.dart';

abstract class IUsuarioRepository {
  Future<Either<IFailure, Pagina<List<Usuario>>>> getUsuarios(Pagina pagina);
  Future<Either<IFailure, Pagina<List<Rol>>>> getRoles(Pagina pagina);
  Future<Either<IFailure, List<Sistema>>> getSistemas();
  Future<Either<IFailure, List<Permiso>>> getPermisos(int rolId);
  Future<Either<IFailure, Rol>> postRol(Rol rol);
  Future<Either<IFailure, bool>> deleteRol(int id);
  Future<Either<IFailure, bool>> addPermiso(int idRol, int idPermiso);
  Future<Either<IFailure, Pagina<List<Permiso>>>> getPermisoPage(Pagina pagina);
  Future<Either<IFailure, Permiso>> postPermiso(Permiso permiso);
  Future<Either<IFailure, bool>> deletePermiso(int id);
  Future<Either<IFailure, bool>> deleteRolUsuario(int idUsuario, int idRol);
  Future<Either<IFailure, Usuario>> createUsuario(UsuarioModel usuario);
}
