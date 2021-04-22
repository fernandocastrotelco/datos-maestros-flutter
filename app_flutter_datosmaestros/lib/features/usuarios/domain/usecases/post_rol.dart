import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class PostRol implements IUseCase<Rol, Rol> {
  final IUsuarioRepository repository;

  PostRol(this.repository);

  @override
  Future<Either<IFailure, Rol>> call(Rol params) async {
    return await repository.postRol(params);
  }
}
