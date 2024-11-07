part of 'now_playing_cubit.dart';

abstract class NowPlayingState {}

class NowPlayingLoading extends NowPlayingState {}

class NowPlayingLoaded extends NowPlayingState {
  final List<MovieEntity> movies;
  NowPlayingLoaded({required this.movies});
}

class NowPlayingError extends NowPlayingState {
  final String error;
  NowPlayingError({required this.error});
}
