import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/permiso.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/iusuario_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetPermisosPage implements IUseCase<Pagina<List<Permiso>>, Pagina> {
  final IUsuarioRepository repository;

  GetPermisosPage(this.repository);

  @override
  Future<Either<IFailure, Pagina<List<Permiso>>>> call(Pagina params) async {
    return await repository.getPermisoPage(params);
  }
}
