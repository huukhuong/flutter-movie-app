import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/common/helpers/navigation/app_navigation.dart';
import 'package:netflix_clone/core/configs/assets/app_images.dart';
import 'package:netflix_clone/presentation/auth/screens/login_screen.dart';
import 'package:netflix_clone/presentation/home/screens/home_screen.dart';
import 'package:netflix_clone/presentation/splash/bloc/splash_cubit.dart';
import 'package:netflix_clone/presentation/splash/bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is UnAuthenticatedSplash) {
            AppNavigation.pushReplacement(context, LoginScreen());
          }

          if (state is AuthenticatedSplash) {
            AppNavigation.pushReplacement(context, const HomeScreen());
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.splashBackground,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xff1a1b20).withOpacity(0),
                    const Color(0xff1a1b20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
