import 'package:netflix_clone/domain/movie/entities/movie.dart';

abstract class TrendingState {}

class TrendingMovieLoading extends TrendingState {}

class TrendingMovieLoaded extends TrendingState {
  final List<MovieEntity> movies;
  TrendingMovieLoaded({required this.movies});
}

class TrendingMovieError extends TrendingState {
  final String error;
  TrendingMovieError({required this.error});
}
