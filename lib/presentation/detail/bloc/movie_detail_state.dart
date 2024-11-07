import 'package:netflix_clone/domain/movie/entities/movie_video.dart';

abstract class MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  List<MovieVideosEntity> videos;
  MovieDetailLoaded({required this.videos});
}

class MovieDetailError extends MovieDetailState {
  String error;
  MovieDetailError({required this.error});
}
