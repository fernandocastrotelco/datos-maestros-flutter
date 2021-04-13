import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/usuario.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetUsuarios implements IUseCase<Pagina<List<Usuario>>, Pagina> {
  final IUsuarioRepository repository;

  GetUsuarios(this.repository);

  @override
  Future<Either<IFailure, Pagina<List<Usuario>>>> call(Pagina params) async {
    return await repository.getUsuarios(params);
  }
}
