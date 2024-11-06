import 'package:dartz/dartz.dart';
import 'package:netflix_clone/core/usecase/usecase.dart';
import 'package:netflix_clone/data/auth/models/signup_req.dart';
import 'package:netflix_clone/domain/auth/repositories/auth_repository.dart';
import 'package:netflix_clone/service_locator.dart';

class SignupUsecase extends Usecase<Either, SignupRequest> {
  @override
  Future<Either> call({SignupRequest? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
}
