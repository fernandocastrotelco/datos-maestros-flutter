import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class DeleteUsuarioRol implements IUseCase<bool, Map<String, int>> {
  final IUsuarioRepository repository;

  DeleteUsuarioRol(this.repository);

  @override
  Future<Either<IFailure, bool>> call(Map<String, int> params) async {
    return await repository.deleteRolUsuario(params['usuario'], params['rol']);
  }
}
