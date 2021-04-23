import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/rol.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/entities/sistema.dart';
import 'package:app_flutter_datosmaestros/features/usuarios/domain/usecases/get_sistemas.dart';
import 'package:app_flutter_datosmaestros/utils/iusecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'usuario_sistema_state.dart';

class UsuarioSistemaCubit extends Cubit<UsuarioSistemaState> {
  final GetSistemas _getSistemas;
  UsuarioSistemaCubit(GetSistemas getSistemas)
      : _getSistemas = getSistemas,
        super(UsuarioSistemaState());

  void init() async {
    final response = await _getSistemas(NoParams());
    final sistemas = response.getOrElse(() => []);
    emit(UsuarioSistemaState(
        lovSistemas: sistemas,
        sistema: sistemas.first,
        lovRoles: sistemas.first.roles));
  }

  void sistemaChanged(Sistema sistema) {
    emit(state.copyWith(
        sistema: sistema, roles: sistema.roles, rol: sistema.roles.first));
  }

  void rolChanged(Rol rol) {
    emit(state.copyWith(rol: rol));
  }
}
