import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetSistemas implements IUseCase<List<Sistema>, NoParams> {
  final IUsuarioRepository repository;

  GetSistemas(this.repository);

  @override
  Future<Either<IFailure, List<Sistema>>> call(NoParams params) async {
    return await repository.getSistemas();
  }
}
