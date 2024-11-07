import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/domain/movie/entities/movie.dart';
import 'package:netflix_clone/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:netflix_clone/service_locator.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit() : super(NowPlayingLoading());

  Future getNowPlayingMovies() async {
    var response = await sl<GetNowPlayingMoviesUsecase>().call();
    response.fold((err) {
      emit(NowPlayingError(error: err));
    }, (data) {
      emit(NowPlayingLoaded(movies: data));
    });
  }
}
