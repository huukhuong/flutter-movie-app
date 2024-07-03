import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/popular_response_model.dart';
import 'package:netflix_clone/models/search_response_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';
import 'package:netflix_clone/services/api.dart';
import 'package:netflix_clone/widgets/loading_progress.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  String searchKeyword = "";
  ApiService apiService = ApiService();
  SearchResponseModel? searchResponseModel;
  late Future<PopularResponseModel> popularMoviesFuture;

  @override
  void initState() {
    super.initState();
    popularMoviesFuture = apiService.getPopularMovies();
  }

  void search(String keyword) {
    apiService.searchMovies(keyword).then((result) {
      setState(() {
        searchResponseModel = result;
      });
    });
  }

  Widget renderSearchBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: CupertinoSearchTextField(
        onChanged: (value) {
          setState(() {
            searchKeyword = value;
          });
          if (value.isNotEmpty) {
            search(value);
          }
        },
        padding: const EdgeInsets.all(10),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        prefixInsets: const EdgeInsets.only(left: 10),
        suffixIcon: const Icon(Icons.cancel, color: Colors.grey),
        suffixInsets: const EdgeInsets.only(right: 10),
        style: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget renderPopular() {
    return FutureBuilder(
        future: popularMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingProgress();
          }

          var data = snapshot.data?.results;
          if (!snapshot.hasData || data == null) {
            return Container();
          }

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Top searches",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  itemCount: data.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movieId: data[index].id ?? 0,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 150,
                          child: Row(
                            children: [
                              data[index].posterPath == null
                                  ? Image.asset(
                                      "assets/netflix.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      "$imageUrl/${data[index].posterPath}",
                                      fit: BoxFit.cover,
                                    ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "${data[index].title}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        });
  }

  Widget renderGridView() {
    if (searchResponseModel == null || searchResponseModel?.results == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: searchResponseModel?.results?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          var item = searchResponseModel?.results?[index];
          if (item == null) {
            return const LoadingProgress();
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(
                    movieId: item.id ?? 0,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                item.posterPath == null
                    ? Image.asset(
                        "assets/netflix.png",
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: "$imageUrl/${item.posterPath}",
                        fit: BoxFit.cover,
                      ),
                SizedBox(
                  child: Text(
                    "${item.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              renderSearchBox(),
              searchKeyword.isEmpty ? renderPopular() : renderGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
