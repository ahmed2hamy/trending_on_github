import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/core/domain/usecases/usecase.dart';
import 'package:trending_on_github/features/splash/domain/use_cases/login_current_user_use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoginCurrentUserUseCase _loginCurrentUserUseCase;

  SplashCubit({
    required LoginCurrentUserUseCase loginCurrentUserUseCase,
  })  : _loginCurrentUserUseCase = loginCurrentUserUseCase,
        super(SplashInitialState());

  Future loginCurrentUser() async {
    final res = await _loginCurrentUserUseCase.call(NoParams());

    res.fold(
      (failure) => emit(SplashErrorState(failure.message)),
      (user) => emit(SplashLoadedState(user)),
    );
  }
}
