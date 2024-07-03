import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/popular_response_model.dart';
import 'package:netflix_clone/models/top_rated_response_model.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/coming_soon_movie.dart';
import 'package:netflix_clone/widgets/loading_progress.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  ApiService apiService = ApiService();
  late Future<PopularResponseModel> popularFuture;
  late Future<TopRatedResponseModel> topRatedFuture;

  @override
  void initState() {
    super.initState();

    popularFuture = apiService.getPopularMovies();
    topRatedFuture = apiService.getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: kBackgroundColor,
            title: const Text(
              "New & Hot",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 27,
                  height: 27,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 15),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: "\t\t\t\t🍿 Coming Soon\t\t\t\t",
                ),
                Tab(
                  text: "\t\t\t\t🔥 Everyone's Watching\t\t\t\t",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: FutureBuilder(
                    future: popularFuture,
                    builder: (context, snapshot) {
                      var data = snapshot.data?.results;
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          data == null) {
                        return const LoadingProgress();
                      }

                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          ...data.map(
                            (e) => ComingSoonMovie(
                              imageUrl: "$imageUrl/${e.backdropPath}",
                              overview: "${e.overview}",
                              month: "${e.releaseDate?.split("-")[1]}",
                              day: "${e.releaseDate?.split("-")[2]}",
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: topRatedFuture,
                    builder: (context, snapshot) {
                      var data = snapshot.data?.results;
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          data == null) {
                        return const LoadingProgress();
                      }

                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          ...data.map(
                            (e) => ComingSoonMovie(
                              imageUrl: "$imageUrl/${e.backdropPath}",
                              overview: "${e.overview}",
                              month: "${e.releaseDate?.split("-")[1]}",
                              day: "${e.releaseDate?.split("-")[2]}",
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
