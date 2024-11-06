import 'package:flutter/material.dart';
import 'package:netflix_clone/common/helpers/navigation/app_navigation.dart';
import 'package:netflix_clone/core/configs/themes/app_colors.dart';
import 'package:netflix_clone/presentation/auth/screens/login_screen.dart';
import 'package:reactive_button/reactive_button.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
              _signupButton(),
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
      'Create an account',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    );
  }

  Widget _emailInput() {
    return const TextField(
      decoration: InputDecoration(hintText: 'Email'),
    );
  }

  Widget _passwordInput() {
    return const TextField(
      decoration: InputDecoration(hintText: 'Password'),
    );
  }

  Widget _signupButton() {
    return ReactiveButton(
      title: 'Signup',
      activeColor: AppColors.primary,
      onPressed: () async => {},
      onSuccess: () {},
      onFailure: (e) {},
    );
  }

  Widget signupText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            AppNavigation.push(context, const LoginScreen());
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 3, right: 3),
          ),
          child: const Text(
            'Login now',
            style: TextStyle(color: AppColors.primary, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
