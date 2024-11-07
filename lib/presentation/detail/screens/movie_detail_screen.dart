import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/common/widgets/app_bar.dart';
import 'package:netflix_clone/common/widgets/my_video_player.dart';
import 'package:netflix_clone/core/configs/assets/app_images.dart';
import 'package:netflix_clone/domain/movie/entities/movie.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_detail_cubit.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_detail_state.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_recommendation_cubit.dart';
import 'package:netflix_clone/presentation/detail/bloc/movie_recommentdation_state.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieEntity movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(movie.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _movieTrailer(movie.id!),
            const Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(movie.overview ?? ''),
            const SizedBox(height: 10),
            _recommendations(movie.id!),
          ],
        ),
      ),
    );
  }

  Widget _movieTrailer(int movieId) {
    return BlocProvider(
      create: (context) => MovieDetailCubit()..getMovieTrailer(movieId),
      child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MovieDetailError) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is MovieDetailLoaded) {
            return MyVideoPlayer(
              videoId: state.videos[0].key ?? '',
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _recommendations(int movieId) {
    return BlocProvider(
      create: (context) =>
          MovieRecommendationCubit()..getMovieRecommendations(movieId),
      child: BlocBuilder<MovieRecommendationCubit, MovieRecommendationState>(
        builder: (context, state) {
          if (state is MovieRecommendationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MovieRecommendationError) {
            return Center(
              child: Text(state.error),
            );
          }

          if (state is MovieRecommendationLoaded) {
            return Expanded(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ...state.movies.map(
                    (item) => SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        '${AppImages.movieImageBasePath}/${item.posterPath}',
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
