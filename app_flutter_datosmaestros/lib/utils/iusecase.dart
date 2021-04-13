import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'ifailures.dart';

abstract class IUseCase<Type, Params> {
  Future<Either<IFailure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
