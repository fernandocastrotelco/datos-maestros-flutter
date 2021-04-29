import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/localidad.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/persona.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/provincia.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:dartz/dartz.dart';

abstract class IPersonaRepository {
  Future<Either<IFailure, List<Provincia>>> getProvincias();
  Future<Either<IFailure, List<Localidad>>> getLocalidades(int provincia);
  Future<Either<IFailure, Persona>> getPersona(Map<String, String> params);
}
