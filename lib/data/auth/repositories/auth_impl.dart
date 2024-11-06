import 'package:dartz/dartz.dart';
import 'package:netflix_clone/data/auth/datasources/auth_api_service.dart';
import 'package:netflix_clone/domain/auth/repositories/auth_repository.dart';
import 'package:netflix_clone/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> login(req) async {
    var data = await sl<AuthApiService>().login(req);
    return data.fold((error) {
      return Left(error);
    }, (data) async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data['user']['token']);
      return Right(data);
    });
  }

  @override
  Future<Either> signup(req) async {
    var data = await sl<AuthApiService>().signup(req);
    return data.fold((error) {
      return Left(error);
    }, (data) async {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', data['user']['token']);
      return Right(data);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    if (token != null) {
      return true;
    }
    return false;
  }
}
