import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class PostPermiso implements IUseCase<Permiso, Permiso> {
  final IUsuarioRepository repository;

  PostPermiso(this.repository);

  @override
  Future<Either<IFailure, Permiso>> call(Permiso params) async {
    return await repository.postPermiso(params);
  }
}
