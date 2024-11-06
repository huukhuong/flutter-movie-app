import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/usecase/usecase.dart';
import 'package:netflix_clone/data/auth/models/login_req.dart';
import 'package:netflix_clone/domain/auth/repositories/auth_repository.dart';
import 'package:netflix_clone/service_locator.dart';

class LoginUsecase extends Usecase<Either, LoginRequest> {
  @override
  Future<Either> call({LoginRequest? params}) async {
    return await sl<AuthRepository>().login(params!);
  }
}
