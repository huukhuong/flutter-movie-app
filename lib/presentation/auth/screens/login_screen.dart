import 'package:flutter/material.dart';
import 'package:netflix_clone/common/helpers/message/display_message.dart';
import 'package:netflix_clone/common/helpers/navigation/app_navigation.dart';
import 'package:netflix_clone/core/configs/themes/app_colors.dart';
import 'package:netflix_clone/data/auth/models/login_req.dart';
import 'package:netflix_clone/domain/auth/usecases/login.dart';
import 'package:netflix_clone/presentation/auth/screens/signup_screen.dart';
import 'package:netflix_clone/presentation/home/screens/home_screen.dart';
import 'package:netflix_clone/service_locator.dart';
import 'package:reactive_button/reactive_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(
          top: 100,
          left: 16,
          right: 16,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _headerText(),
              const SizedBox(height: 30),
              _emailInput(),
              const SizedBox(height: 20),
              _passwordInput(),
              const SizedBox(height: 20),
              _loginButton(context),
              const SizedBox(height: 10),
              signupText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerText() {
    return const Text(
      'Login',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _emailInput() {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _passwordInput() {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ReactiveButton(
      title: 'Login',
      activeColor: AppColors.primary,
      onPressed: () async => await sl<LoginUsecase>().call(
        params: LoginRequest(
          email: _email.text,
          password: _password.text,
        ),
      ),
      onSuccess: () {
        AppNavigation.pushAndRemove(context, const HomeScreen());
      },
      onFailure: (e) {
        DisplayMessage.errorMessage(context, e);
      },
    );
  }

  Widget signupText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            AppNavigation.push(context, SignupScreen());
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 3, right: 3),
          ),
          child: const Text(
            'Sign up now',
            style: TextStyle(color: AppColors.primary, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
