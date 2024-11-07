import 'package:netflix_clone/data/movie/models/movie.dart';

class MovieEntity {
  MovieEntity({
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final String? backdropPath;
  final int? id;
  final String? title;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  final bool? adult;
  final String? originalLanguage;
  final List<int> genreIds;
  final double? popularity;
  final DateTime? releaseDate;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  double calculatePopularityScore() {
    return (voteAverage ?? 0) * (voteCount ?? 0);
  }

  static MovieEntity fromModel(MovieModel model) {
    return MovieEntity(
      id: model.id,
      title: model.title,
      overview: model.overview,
      releaseDate: model.releaseDate,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath,
      voteAverage: model.voteAverage,
      voteCount: model.voteCount,
      adult: model.adult,
      genreIds: model.genreIds,
      originalLanguage: model.originalLanguage,
      originalTitle: model.originalTitle,
      popularity: model.popularity,
      video: model.video,
    );
  }
}
