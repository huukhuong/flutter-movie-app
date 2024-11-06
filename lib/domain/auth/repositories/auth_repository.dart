import 'package:dartz/dartz.dart';
import 'package:netflix_clone/data/auth/models/login_req.dart';
import 'package:netflix_clone/data/auth/models/signup_req.dart';

abstract class AuthRepository {
  Future<Either> login(LoginRequest req);
  Future<Either> signup(SignupRequest req);
  Future<bool> isLoggedIn();
}
