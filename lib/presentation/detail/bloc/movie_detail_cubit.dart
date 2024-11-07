import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/domain/movie/usecases/get_movie_trailer.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_detail_state.dart';
import 'package:netflix_clone/service_locator.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailLoading());

  Future getMovieTrailer(int movieId) async {
    var response = await sl<GetMovieTrailerUsecase>().call(params: movieId);

    response.fold((error) {
      emit(MovieDetailError(error: error));
    }, (data) {
      emit(MovieDetailLoaded(videos: data));
    });
  }
}
