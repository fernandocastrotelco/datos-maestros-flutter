import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/ipersona_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetProvincias implements IUseCase<List<Provincia>, NoParams> {
  final IPersonaRepository repository;

  GetProvincias(this.repository);

  @override
  Future<Either<IFailure, List<Provincia>>> call(NoParams params) async {
    return await repository.getProvincias();
  }
}
