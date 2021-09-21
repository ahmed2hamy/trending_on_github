import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';

abstract class SplashRemoteDataSource {
  Future<Either<Failure, User>> loginCurrentUser();
}

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  SplashRemoteDataSourceImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<Failure, User>> loginCurrentUser() async {
    final User? user = _firebaseAuth.currentUser;
    final String? token = await user?.getIdToken();
    if (user != null && token != null) {
      return Right(user);
    } else {
      return const Left(ServerFailure());
    }
  }
}
