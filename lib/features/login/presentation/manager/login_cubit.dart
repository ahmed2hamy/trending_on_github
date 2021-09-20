import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/login/domain/use_cases/login_current_user_use_case.dart';
import 'package:news_app/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginCurrentUserUseCase loginCurrentUserUseCase;
  final LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase;

  LoginCubit({
    required this.loginCurrentUserUseCase,
    required this.loginWithEmailAndPasswordUseCase,
  }) : super(LoginInitialState());

  Future loginCurrentUser() async {
    final res =
        await loginCurrentUserUseCase.repository.loginCurrentUserEvent();

    res.fold(
      (failure) => emit(LoginInitialState()),
      (user) => emit(LoginCurrentUserState(user)),
    );
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final res = await loginWithEmailAndPasswordUseCase.repository
        .loginWithEmailAndPasswordEvent(
      email: email,
      password: password,
    );

    res.fold(
      (failure) => emit(LoginErrorState(message: failure.message)),
      (userCredential) => emit(LoginWithEmailAndPasswordState(userCredential)),
    );
  }
}
