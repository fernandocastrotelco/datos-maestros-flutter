import 'package:app_flutter_datosmaestros/features/usuarios/data/models/usuario_model.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class CreateUsuario implements IUseCase<Usuario, UsuarioModel> {
  final IUsuarioRepository repository;

  CreateUsuario(this.repository);

  @override
  Future<Either<IFailure, Usuario>> call(UsuarioModel params) async {
    return await repository.createUsuario(params);
  }
}
