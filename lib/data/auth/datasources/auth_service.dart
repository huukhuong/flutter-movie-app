import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:netflix_clone/core/constants/api_url.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/data/auth/models/login_req.dart';
import 'package:netflix_clone/data/auth/models/signup_req.dart';
import 'package:netflix_clone/service_locator.dart';

abstract class AuthService {
  Future<Either> login(LoginRequest req);
  Future<Either> signup(SignupRequest req);
}

class AuthServiceImpl extends AuthService {
  @override
  Future<Either> login(LoginRequest req) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.login,
        data: req.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }

  @override
  Future<Either> signup(SignupRequest req) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrl.signup,
        data: req.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'Unknown error');
    }
  }
}
