import 'package:netflix_clone/domain/movie/entities/movie.dart';

abstract class MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<MovieEntity> movies;
  MovieRecommendationLoaded({required this.movies});
}

class MovieRecommendationError extends MovieRecommendationState {
  final String error;
  MovieRecommendationError({required this.error});
}
