import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/login/domain/repositories/login_repository.dart';

class LoginWithEmailAndPasswordUseCase
    implements UseCase<UserCredential, Params> {
  final LoginRepository _repository;

  LoginWithEmailAndPasswordUseCase({
    required LoginRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, UserCredential>> call(Params params) async {
    return _repository.loginWithEmailAndPasswordEvent(
        email: params.email, password: params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
