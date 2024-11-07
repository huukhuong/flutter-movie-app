import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/domain/movie/usecases/get_movie_recommendations.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_recommentdation_state.dart';
import 'package:netflix_clone/service_locator.dart';

class MovieRecommendationCubit extends Cubit<MovieRecommendationState> {
  MovieRecommendationCubit() : super(MovieRecommendationLoading());

  Future getMovieRecommendations(int movieId) async {
    var response =
        await sl<GetMovieRecommendationsUsecase>().call(params: movieId);

    response.fold((error) {
      emit(MovieRecommendationError(error: error));
    }, (data) {
      emit(MovieRecommendationLoaded(movies: data));
    });
  }
}
