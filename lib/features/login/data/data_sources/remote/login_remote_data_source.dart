import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  LoginRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
