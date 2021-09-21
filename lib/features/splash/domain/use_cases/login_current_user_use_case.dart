import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/splash/domain/repositories/splash_repository.dart';

class LoginCurrentUserUseCase implements UseCase<User, NoParams> {
  final SplashRepository _repository;

  LoginCurrentUserUseCase({required SplashRepository repository})
      : _repository = repository;

  @override
  Future<Either<Failure, User>> call(NoParams noParams) async {
    return _repository.loginCurrentUserEvent();
  }
}
