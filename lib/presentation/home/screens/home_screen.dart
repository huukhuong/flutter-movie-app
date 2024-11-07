import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix_clone/common/widgets/app_bar.dart';
import 'package:netflix_clone/core/configs/assets/app_vectors.dart';
import 'package:netflix_clone/presentation/home/widgets/now_playing.dart';
import 'package:netflix_clone/presentation/home/widgets/trending.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        title: SvgPicture.asset(AppVectors.logo),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrendingMovies(),
            NowPlaying(),
          ],
        ),
      ),
    );
  }
}
