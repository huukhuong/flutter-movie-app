import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/top_rated_response_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';
import 'package:netflix_clone/widgets/loading_progress.dart';

class CustomCarousel extends StatelessWidget {
  final Future<TopRatedResponseModel> future;

  const CustomCarousel({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = 260.0;

    return SizedBox(
      width: size.width,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          var data = snapshot.data?.results;

          if (data == null) {
            return const LoadingProgress();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CarouselSlider.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(movieId: data[index].id ?? 0),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$imageUrl/${data[index].backdropPath}",
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${data[index].title?.trim()}",
                        maxLines: 1,
                      ),
                    ],
                  ),
                );
              },
              options: CarouselOptions(
                height: height,
                aspectRatio: 16 / 9,
                reverse: false,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
