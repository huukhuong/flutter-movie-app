class MovieModel {
  MovieModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      genreIds: json["genre_ids"] == null
          ? []
          : List<int>.from(json["genre_ids"]!.map((x) => x)),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"],
      posterPath: json["poster_path"],
      releaseDate: DateTime.tryParse(json["release_date"] ?? ""),
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
    );
  }

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds.map((x) => x).toList(),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": "",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
