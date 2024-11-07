import 'package:dartz/dartz.dart';
import 'package:netflix_clone/data/movie/datasources/movie_service.dart';
import 'package:netflix_clone/data/movie/models/movie.dart';
import 'package:netflix_clone/data/movie/models/movie_recommendation.dart';
import 'package:netflix_clone/data/movie/models/movie_video.dart';
import 'package:netflix_clone/domain/movie/entities/movie.dart';
import 'package:netflix_clone/domain/movie/entities/movie_video.dart';
import 'package:netflix_clone/domain/movie/repositories/movie_repository.dart';
import 'package:netflix_clone/service_locator.dart';

class MovieRepositoryImpl extends MovieRepository {
  @override
  Future<Either> getTrendingMovies() async {
    var response = await sl<MovieService>().getTrendingMovies();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var movie = List.from(data['results'])
          .map((m) => MovieEntity.fromModel(MovieModel.fromJson(m)))
          .toList();
      return Right(movie);
    });
  }

  @override
  Future<Either> getNowPlayingMovies() async {
    var response = await sl<MovieService>().getNowPlayingMovies();

    return response.fold((error) {
      return Left(error);
    }, (data) {
      var movie = List.from(data['results'])
          .map((m) => MovieEntity.fromModel(MovieModel.fromJson(m)))
          .toList();
      return Right(movie);
    });
  }

  @override
  Future<Either> getMovieTrailer(int movieId) async {
    var response = await sl<MovieService>().getMovieTrailer(movieId);
    return response.fold((error) {
      return Left(error);
    }, (data) {
      var movie = List.from(data['results'])
          .map((m) => MovieVideosEntity.fromModel(MovieVideosModel.fromJson(m)))
          .toList();
      return Right(movie);
    });
  }

  @override
  Future<Either> getMovieRecommendations(int movieId) async {
    var response = await sl<MovieService>().getMovieRecommendations(movieId);
    return response.fold((error) {
      return Left(error);
    }, (data) {
      var movie = List.from(data['results'])
          .map((m) => MovieEntity.fromRecommendationModel(
              MovieRecommendationModel.fromJson(m)))
          .toList();
      return Right(movie);
    });
  }
}
