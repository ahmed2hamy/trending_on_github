part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitialState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadedState extends LoginState {
  final UserCredential userCredential;

  const LoginLoadedState(this.userCredential);

  @override
  List<Object> get props => [userCredential];
}

class LoginErrorState extends LoginState {
  final String? message;

  const LoginErrorState({this.message});

  @override
  List<Object> get props => [];
}
