import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class AddUsuarioRol implements IUseCase<bool, Map<String, int>> {
  final ISistemaRepository repository;

  AddUsuarioRol(this.repository);

  @override
  Future<Either<IFailure, bool>> call(Map<String, int> params) async {
    return await repository.addUsuarioRol(params['usuario'], params['rol']);
  }
}
