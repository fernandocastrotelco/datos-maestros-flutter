import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/pagina.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/repositories/isistema_repository.dart';
import 'package:app_flutter_datosmaestros/utils/ifailures.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetSistemasPage implements IUseCase<Pagina<List<Sistema>>, Pagina> {
  final ISistemaRepository repository;

  GetSistemasPage(this.repository);

  @override
  Future<Either<IFailure, Pagina<List<Sistema>>>> call(Pagina params) async {
    return await repository.getSistemas(params);
  }
}
