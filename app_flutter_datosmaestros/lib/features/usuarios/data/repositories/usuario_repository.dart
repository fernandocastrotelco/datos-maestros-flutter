import 'package:app_flutter_datosmaestros/features/usuarios/data/datasources/login_remote_datasource.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
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
}
