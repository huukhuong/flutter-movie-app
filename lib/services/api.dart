import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_detail_model.dart';
import 'package:netflix_clone/models/popular_response_model.dart';
import 'package:netflix_clone/models/related_movies_response_model.dart';
import 'package:netflix_clone/models/search_response_model.dart';
import 'package:netflix_clone/models/top_rated_response_model.dart';
import 'package:netflix_clone/models/upcoming_response_model.dart';

const params = "api_key=$apiKey&language=$language";

class ApiService {
  Future<TopRatedResponseModel> getTopRatedMovies() async {
    const requestUrl = "$baseUrl/movie/top_rated?$params";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load top rated movies");
      return TopRatedResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load top rated movies");
    }
  }

  Future<UpcomingResponseModel> getUpcomingMovies() async {
    const requestUrl = "$baseUrl/movie/upcoming?$params";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load upcoming movies");
      return UpcomingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load upcoming movies");
    }
  }

  Future<UpcomingResponseModel> getNowPlayingMovies() async {
    const requestUrl = "$baseUrl/movie/now_playing?$params";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load now playing movies");
      return UpcomingResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load now playing movies");
    }
  }

  Future<SearchResponseModel> searchMovies(String keyword) async {
    var requestUrl = "$baseUrl/search/movie?$params&query=$keyword";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success search movies");
      return SearchResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to search movies");
    }
  }

  Future<PopularResponseModel> getPopularMovies() async {
    var requestUrl = "$baseUrl/movie/popular?$params";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load popular movies");
      return PopularResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load popular movies");
    }
  }

  Future<MovieDetailModel> getMovieDetail(int id) async {
    var requestUrl = "$baseUrl/movie/$id?$params";
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load movie detail");
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load movie detail");
    }
  }

  Future<RelatedMoviesResponseModel> getRelatedMovies(int movieId) async {
    var requestUrl = "$baseUrl/movie/$movieId/recommendations?$params";

    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      log("Success load related movies");
      return RelatedMoviesResponseModel.fromJson(jsonDecode(response.body));
    } else {
      log("Error");
      throw Exception("Failed to load related movies");
    }
  }
}
