import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netflix_clone/core/constants/api_url.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/service_locator.dart';

abstract class MovieService {
  Future<Either> getTrendingMovies();
  Future<Either> getNowPlayingMovies();
}

class MovieServiceImpl extends MovieService {
  @override
  Future<Either> getTrendingMovies() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.trendingMovies,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }

  @override
  Future<Either> getNowPlayingMovies() async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrl.nowPlayingMovies,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }
}
