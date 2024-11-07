class ApiUrl {
  static const baseUrl =
      'https://netflix-backend-production-8413.up.railway.app/api/v1';

  static const login = '/auth/signin';
  static const signup = '/auth/signup';

  static const tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const tmdbApiKey = '?api_key=d3d1d0e2d958b3d2aa833a86e2db7d32';

  static const movie = '$tmdbBaseUrl/movie';
  static const trendingMovies = '$movie/popular$tmdbApiKey';
  static const nowPlayingMovies = '$movie/now_playing$tmdbApiKey';
}
