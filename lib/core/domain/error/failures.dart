import 'package:equatable/equatable.dart';
import 'package:trending_on_github/constants/constants.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({String? message})
      : super(message: message ?? Strings.defaultErrorMessage);
}

class CacheFailure extends Failure {
  const CacheFailure({String? message})
      : super(message: message ?? Strings.defaultErrorMessage);
}
