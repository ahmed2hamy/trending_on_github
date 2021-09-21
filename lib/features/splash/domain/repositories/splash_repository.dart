import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, User>> loginCurrentUserEvent();
}
