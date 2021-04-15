import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetPermisos implements IUseCase<List<Permiso>, String> {
  final IUsuarioRepository repository;

  GetPermisos(this.repository);

  @override
  Future<Either<IFailure, List<Permiso>>> call(String params) async {
    return await repository.getPermisos(params);
  }
}
