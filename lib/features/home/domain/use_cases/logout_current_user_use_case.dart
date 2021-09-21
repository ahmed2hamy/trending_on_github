import 'package:dartz/dartz.dart';
import 'package:trending_on_github/core/data/models/success_model.dart';
import 'package:trending_on_github/core/domain/error/failures.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/home/domain/repositories/trending_repos_repository.dart';

class LogoutCurrentUserUseCase extends UseCase<SuccessModel, NoParams> {
  final TrendingReposRepository _repository;

  LogoutCurrentUserUseCase({
    required TrendingReposRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, SuccessModel>> call(NoParams noParams) async {
    return await _repository.logoutCurrentUserEvent();
  }
}
