// General failures
part of 'ifailures.dart';

class ServerFailure extends IFailure {
  final String message;

  ServerFailure({this.message});

  @override
  List<Object> get props => [];
}
