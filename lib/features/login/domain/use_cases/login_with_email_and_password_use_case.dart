import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/domain/error/failures.dart';
import 'package:news_app/core/domain/usecases/usecase.dart';
import 'package:news_app/features/login/domain/repositories/login_repository.dart';

class LoginWithEmailAndPasswordUseCase
    implements UseCase<UserCredential, Params> {
  final LoginRepository repository;

  LoginWithEmailAndPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(Params params) async {
    return repository.loginWithEmailAndPasswordEvent(
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
