import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/related_movies_response_model.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/loading_progress.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiService apiService = ApiService();
  late Future<MovieDetailModel> movieDetailFuture;
  late Future<RelatedMoviesResponseModel> relatedMoviesFuture;

  @override
  void initState() {
    super.initState();

    movieDetailFuture = apiService.getMovieDetail(widget.movieId);
    relatedMoviesFuture = apiService.getRelatedMovies(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: movieDetailFuture,
        builder: (context, snapshot) {
          var data = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting ||
              data == null) {
            return const Center(
              child: LoadingProgress(),
            );
          }

          String genresText = data.genres != null
              ? data.genres!.map((genre) => genre.name).join(', ')
              : "";

          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    data.backdropPath == null
                        ? Image.asset("assets/netflix.png")
                        : CachedNetworkImage(
                            imageUrl: "$imageUrl/${data.backdropPath}",
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: data.posterPath == null
                                ? Image.asset("assets/netflix.png")
                                : CachedNetworkImage(
                                    imageUrl: "$imageUrl/${data.posterPath}",
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${data.title} (${data.releaseDate?.split("-")[0]})",
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          genresText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${data.overview}",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text("More like this"),
                      SizedBox(
                        child: FutureBuilder(
                          future: relatedMoviesFuture,
                          builder: (context, snapshot) {
                            var data = snapshot.data?.results;
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                data == null) {
                              return const LoadingProgress();
                            }

                            return GridView.builder(
                              itemCount: data.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 3,
                                crossAxisSpacing: 3,
                                childAspectRatio: 0.5,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetailScreen(
                                            movieId: data[index].id ?? 0,
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: data[index].posterPath == null
                                          ? Image.asset(
                                              "assets/netflix.png",
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl:
                                                  "$imageUrl/${data[index].posterPath}",
                                              fit: BoxFit.cover,
                                            ),
                                    ));
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
