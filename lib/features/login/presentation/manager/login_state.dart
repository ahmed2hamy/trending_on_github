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

class LoginCurrentUserState extends LoginState {
  final User user;

  const LoginCurrentUserState(this.user);

  @override
  List<Object> get props => [user];
}

class LoginWithEmailAndPasswordState extends LoginState {
  final UserCredential userCredential;

  const LoginWithEmailAndPasswordState(this.userCredential);

  @override
  List<Object> get props => [userCredential];
}

class LoginErrorState extends LoginState {
  final String? message;

  const LoginErrorState({this.message});

  @override
  List<Object> get props => [];
}
