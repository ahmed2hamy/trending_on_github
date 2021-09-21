import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trending_on_github/features/login/domain/use_cases/login_with_email_and_password_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;

  LoginCubit({
    required LoginWithEmailAndPasswordUseCase loginWithEmailAndPasswordUseCase,
  })  : _loginWithEmailAndPasswordUseCase = loginWithEmailAndPasswordUseCase,
        super(LoginInitialState());

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    final res = await _loginWithEmailAndPasswordUseCase.call(Params(
      email: email,
      password: password,
    ));

    res.fold(
      (failure) => emit(LoginErrorState(message: failure.message)),
      (userCredential) => emit(LoginLoadedState(userCredential)),
    );
  }
}
