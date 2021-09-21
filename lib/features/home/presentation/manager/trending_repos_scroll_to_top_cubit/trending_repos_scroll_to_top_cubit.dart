import 'package:bloc/bloc.dart';

class TrendingReposScrollToTopCubit extends Cubit<bool> {
  TrendingReposScrollToTopCubit() : super(false);

  void showBackToTopButton() {
    emit(true);
  }

  void hideBackToTopButton() {
    emit(false);
  }
}
