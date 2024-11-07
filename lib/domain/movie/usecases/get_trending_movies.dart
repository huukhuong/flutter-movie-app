import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/usecase/usecase.dart';
import 'package:netflix_clone/domain/movie/repositories/movie_repository.dart';
import 'package:netflix_clone/service_locator.dart';

class GetTrendingMoviesUsecase extends Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<MovieRepository>().getTrendingMovies();
  }
}
