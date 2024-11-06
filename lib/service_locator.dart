import 'package:get_it/get_it.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/data/auth/datasources/auth_api_service.dart';
import 'package:netflix_clone/data/auth/repositories/auth_impl.dart';
import 'package:netflix_clone/domain/auth/repositories/auth_repository.dart';
import 'package:netflix_clone/domain/auth/usecases/is_logged_in.dart';
import 'package:netflix_clone/domain/auth/usecases/login.dart';
import 'package:netflix_clone/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Auth
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerSingleton<SignupUsecase>(SignupUsecase());
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
}
