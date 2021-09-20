import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/domain/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, User>> loginCurrentUserEvent();

  Future<Either<Failure, UserCredential>> loginWithEmailAndPasswordEvent({
    required String email,
    required String password,
  });
}
