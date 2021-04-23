import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:dartz/dartz.dart';

abstract class ISistemaRepository {
  Future<Either<IFailure, Pagina<List<Sistema>>>> getSistemas(Pagina pagina);
  Future<Either<IFailure, Sistema>> postSistema(Sistema sistema);
  Future<Either<IFailure, bool>> addRol(int idSistema, int idRol);
  Future<Either<IFailure, bool>> addUsuarioRol(int idUsuario, int idRol);
}
