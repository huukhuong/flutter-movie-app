import 'package:get_it/get_it.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/data/auth/datasources/auth_service.dart';
import 'package:netflix_clone/data/auth/repositories/auth_repo_impl.dart';
import 'package:netflix_clone/data/movie/datasources/movie_service.dart';
import 'package:netflix_clone/data/movie/repositories/movie_repo_impl.dart';
import 'package:netflix_clone/domain/auth/repositories/auth_repository.dart';
import 'package:netflix_clone/domain/auth/usecases/is_logged_in.dart';
import 'package:netflix_clone/domain/auth/usecases/login.dart';
import 'package:netflix_clone/domain/auth/usecases/signup.dart';
import 'package:netflix_clone/domain/movie/repositories/movie_repository.dart';
import 'package:netflix_clone/domain/movie/usecases/get_now_playing_movies.dart';
import 'package:netflix_clone/domain/movie/usecases/get_trending_movies.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Auth
  sl.registerSingleton<AuthService>(AuthServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());

  // Movie
  sl.registerSingleton<MovieService>(MovieServiceImpl());
  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl());
  sl.registerSingleton<GetTrendingMoviesUsecase>(GetTrendingMoviesUsecase());
  sl.registerSingleton<GetNowPlayingMoviesUsecase>(
      GetNowPlayingMoviesUsecase());
}
