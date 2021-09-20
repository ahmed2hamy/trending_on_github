import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/domain/error/failures.dart';
import 'package:news_app/core/domain/usecases/usecase.dart';
import 'package:news_app/features/login/domain/repositories/login_repository.dart';

class LoginCurrentUserUseCase implements UseCase<User, NoParams> {
  final LoginRepository repository;

  LoginCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    return repository.loginCurrentUserEvent();
  }
}
