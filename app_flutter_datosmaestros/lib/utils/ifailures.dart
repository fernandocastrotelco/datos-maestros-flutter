import 'package:equatable/equatable.dart';
part 'failures.dart';

abstract class IFailure extends Equatable {
  IFailure([List properties = const <dynamic>[]]);
}
