import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetRoles implements IUseCase<Pagina<List<Rol>>, Pagina> {
  final IUsuarioRepository repository;

  GetRoles(this.repository);

  @override
  Future<Either<IFailure, Pagina<List<Rol>>>> call(Pagina params) async {
    return await repository.getRoles(params);
  }
}
