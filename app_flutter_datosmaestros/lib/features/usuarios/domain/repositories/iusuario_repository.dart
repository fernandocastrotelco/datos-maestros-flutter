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
  Future<Either<IFailure, List<Permiso>>> getPermisos(String consulta);
}
