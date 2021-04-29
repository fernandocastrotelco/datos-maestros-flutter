import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/ipersona_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetPersona implements IUseCase<Persona, Map<String, String>> {
  final IPersonaRepository repository;

  GetPersona(this.repository);

  @override
  Future<Either<IFailure, Persona>> call(Map<String, String> params) async {
    return await repository.getPersona(params);
  }
}
