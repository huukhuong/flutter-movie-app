import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/core/configs/assets/app_images.dart';
import 'package:netflix_clone/presentation/home/bloc/now_playing_cubit.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingCubit()..getNowPlayingMovies(),
      child: BlocBuilder<NowPlayingCubit, NowPlayingState>(
        builder: (context, state) {
          if (state is NowPlayingLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is NowPlayingError) {
            return Text(state.error);
          }

          if (state is NowPlayingLoaded) {
            var length = state.movies.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Text(
                    'Now playing',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 260,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var movie = state.movies[index];

                      return SizedBox(
                        width: 120,
                        child: Column(
                          children: [
                            Image.network(
                              '${AppImages.movieImageBasePath}/${movie.posterPath}',
                              height: 180,
                              width: 120,
                            ),
                            Text(
                              movie.originalTitle ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Text(
                                  '${(movie.voteAverage ?? 0).roundToDouble()}',
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: length,
                  ),
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
