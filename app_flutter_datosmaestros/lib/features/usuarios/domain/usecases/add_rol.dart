import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class AddRol implements IUseCase<bool, Map<String, int>> {
  final ISistemaRepository repository;

  AddRol(this.repository);

  @override
  Future<Either<IFailure, bool>> call(Map<String, int> params) async {
    return await repository.addRol(params['sistema'], params['rol']);
  }
}
