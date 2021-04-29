import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/ipersona_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetLocalidades implements IUseCase<List<Localidad>, int> {
  final IPersonaRepository repository;

  GetLocalidades(this.repository);

  @override
  Future<Either<IFailure, List<Localidad>>> call(int params) async {
    return await repository.getLocalidades(params);
  }
}
