import 'package:flutter/material.dart';
import 'package:flutter_bigpay_movie_app/core/utils/constant/app_constant.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/models.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/presentation/widgets/movie_card.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bigpay_movie_app/keys/features/popular_movies/presentation/widgets/movie_card_keys.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../../di/generated_mocks.mocks.dart';
import '../../../../mocks/popular_movies_mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PopularMoviesRepository popularMoviesRepository;

  setUpAll(() {
    popularMoviesRepository = MockPopularMoviesRepository();

    GetIt.instance.registerSingleton(popularMoviesRepository);

    const String posterPath = "/epsz7OqjwmeK1ehItgz1OVzxOH9.jpg";
    const String posterUrl = moviePosterPrefixUrl + posterPath;

    when(popularMoviesRepository.getMoviePosterUrl(moviePosterPath: posterPath))
        .thenAnswer((_) => posterUrl);
  });

  Widget buildMovieCard(PopularMovies? movies) =>
      MaterialApp(home: MovieCard(movies));

  testWidgets('should display movie card container.',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildMovieCard(mockMovies));
    await tester.pump();

    expect(find.byKey(movieCardContainerKey), findsOneWidget);
  });

  testWidgets('should display movie card image.', (WidgetTester tester) async {
    await tester.pumpWidget(buildMovieCard(mockMovies));
    await tester.pump();

    expect(find.byKey(movieCardImageKey), findsOneWidget);
  });
}
