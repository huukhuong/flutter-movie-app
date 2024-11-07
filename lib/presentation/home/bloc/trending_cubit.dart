import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/domain/movie/usecases/get_trending_movies.dart';
import 'package:netflix_clone/presentation/home/bloc/trending_state.dart';
import 'package:netflix_clone/service_locator.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(TrendingMovieLoading());

  Future getTrendingMovies() async {
    var response = await sl<GetTrendingMoviesUsecase>().call();
    response.fold((err) {
      emit(TrendingMovieError(error: err));
    }, (data) {
      emit(TrendingMovieLoaded(movies: data));
    });
  }
}
