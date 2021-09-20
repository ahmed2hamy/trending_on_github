import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/domain/error/failures.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, User>> loginCurrentUser();

  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password});
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  LoginRemoteDataSourceImpl({
    required this.firebaseAuth,
  });

  @override
  Future<Either<Failure, User>> loginCurrentUser() async {
    final User? user = firebaseAuth.currentUser;
    final String? token = await user?.getIdToken();
    if (user != null && token != null) {
      return Right(user);
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
