import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/core/configs/assets/app_images.dart';
import 'package:netflix_clone/presentation/home/bloc/trending_cubit.dart';
import 'package:netflix_clone/presentation/home/bloc/trending_state.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => TrendingCubit()..getTrendingMovies(),
      child: BlocBuilder<TrendingCubit, TrendingState>(
        builder: (context, state) {
          if (state is TrendingMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TrendingMovieError) {
            return Text(state.error);
          }

          if (state is TrendingMovieLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    "Trendings 🔥",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                FanCarouselImageSlider.sliderType1(
                  imagesLink: state.movies
                      .map((e) =>
                          AppImages.movieImageBasePath +
                          e.posterPath.toString())
                      .toList(),
                  isAssets: false,
                  autoPlay: false,
                  showIndicator: false,
                  currentItemShadow: const [],
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
