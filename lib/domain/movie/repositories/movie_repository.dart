import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either> getTrendingMovies();
  Future<Either> getNowPlayingMovies();
  Future<Either> getMovieTrailer(int movieId);
  Future<Either> getMovieRecommendations(int movieId);
}
