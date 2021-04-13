import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:dartz/dartz.dart';

abstract class IUsuarioRepository {
  Future<Either<IFailure, Pagina<List<Usuario>>>> getUsuarios(Pagina pagina);
}
