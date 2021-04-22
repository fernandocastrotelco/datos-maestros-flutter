import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class DeleteRol implements IUseCase<bool, int> {
  final IUsuarioRepository repository;

  DeleteRol(this.repository);

  @override
  Future<Either<IFailure, bool>> call(int params) async {
    return await repository.deleteRol(params);
  }
}
