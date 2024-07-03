import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/top_rated_response_model.dart';
import 'package:netflix_clone/models/upcoming_response_model.dart';
import 'package:netflix_clone/screens/search_screen.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/custom_carousel.dart';
import 'package:netflix_clone/widgets/movie_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  late Future<TopRatedResponseModel> topRatedFuture;
  late Future<UpcomingResponseModel> upcomingFuture;
  late Future<UpcomingResponseModel> nowPlayingFuture;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();

    topRatedFuture = apiService.getTopRatedMovies();
    upcomingFuture = apiService.getUpcomingMovies();
    nowPlayingFuture = apiService.getNowPlayingMovies();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        actions: [
          InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              )
            },
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
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
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCarousel(future: topRatedFuture),
            SizedBox(
              height: 250,
              child: MovieCardWidget(
                future: upcomingFuture,
                headLineText: "Upcoming Movies",
              ),
            ),
            SizedBox(
              height: 250,
              child: MovieCardWidget(
                future: nowPlayingFuture,
                headLineText: "Now Playing",
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
