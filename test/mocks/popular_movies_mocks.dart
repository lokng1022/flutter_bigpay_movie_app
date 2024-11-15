import 'package:flutter_bigpay_movie_app/features/popular_movies/models/popular_movies.dart';

PopularMovies get mockMovies => PopularMovies(
      adult: false,
      backdropPath: '/path.jpg',
      genreIds: [1],
      id: 1,
      originalLanguage: 'en',
      originalTitle: 'Original Title',
      overview: 'Overview',
      popularity: 100.0,
      posterPath: '/epsz7OqjwmeK1ehItgz1OVzxOH9.jpg',
      releaseDate: '2022-01-01',
      title: 'Movie Title',
      video: false,
      voteAverage: 7.5,
      voteCount: 100,
    );
