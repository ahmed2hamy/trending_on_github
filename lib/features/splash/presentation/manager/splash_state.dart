part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashLoadedState extends SplashState {
  final User user;

  const SplashLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class SplashErrorState extends SplashState {
  final String message;

  const SplashErrorState(this.message);

  @override
  List<Object> get props => [];
}
