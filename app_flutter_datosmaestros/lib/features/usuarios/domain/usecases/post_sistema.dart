import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class PostSistema implements IUseCase<Sistema, Sistema> {
  final ISistemaRepository repository;

  PostSistema(this.repository);

  @override
  Future<Either<IFailure, Sistema>> call(Sistema params) async {
    return await repository.postSistema(params);
  }
}
