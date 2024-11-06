import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/domain/auth/usecases/is_logged_in.dart';
import 'package:netflix_clone/presentation/splash/bloc/splash_state.dart';
import 'package:netflix_clone/service_locator.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 1));
    var isLoggedIn = await sl<IsLoggedInUsecase>().call();
    if (isLoggedIn) {
      emit(AuthenticatedSplash());
    } else {
      emit(UnAuthenticatedSplash());
    }
  }
}
