import 'package:flutter/material.dart';
import 'package:flutter_bigpay_movie_app/core/utils/constant/app_constant.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/presentation/pages/movie_page.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/states/popular_movies_cubit.dart';
import 'package:flutter_bigpay_movie_app/keys/features/popular_movies/presentation/pages/movies_page_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../../../di/generated_mocks.mocks.dart';
import '../../../../mocks/popular_movies_mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PopularMoviesRepository popularMoviesRepository;
  late PopularMoviesCubit moviesCubit;

  setUpAll(() {
    popularMoviesRepository = MockPopularMoviesRepository();
    moviesCubit = MockPopularMoviesCubit();

    GetIt.instance.registerSingleton(popularMoviesRepository);

    const String posterPath = "/epsz7OqjwmeK1ehItgz1OVzxOH9.jpg";
    const String posterUrl = moviePosterPrefixUrl + posterPath;

    when(popularMoviesRepository.getMoviePosterUrl(moviePosterPath: posterPath))
        .thenAnswer((_) => posterUrl);
  });

  Widget buildMoviePage() => MaterialApp(
        home: BlocProvider<PopularMoviesCubit>(
          create: (_) => moviesCubit,
          child: const MoviePage(),
        ),
      );

  testWidgets('should display movie page.', (WidgetTester tester) async {
    when(moviesCubit.state).thenReturn(
      PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies]),
    );

    when(moviesCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies])),
    );

    await tester.pumpWidget(buildMoviePage());
    await tester.pump();

    expect(find.byKey(moviePageScaffoldKey), findsOneWidget);
  });

  testWidgets('should display loading indicator while fetching data.',
      (WidgetTester tester) async {
    when(moviesCubit.state).thenReturn(PopularMoviesLoadingState());

    when(moviesCubit.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesLoadingState()));

    await tester.pumpWidget(buildMoviePage());
    await tester.pump();

    expect(find.byKey(moviePageLoadingIndicatorKey), findsOneWidget);
  });

  testWidgets('should display movie page appbar widget.',
      (WidgetTester tester) async {
    when(moviesCubit.state).thenReturn(
      PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies]),
    );

    when(moviesCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies])),
    );

    await tester.pumpWidget(buildMoviePage());
    await tester.pump();

    expect(find.byKey(moviePageAppbarKey), findsOneWidget);
  });

  testWidgets('should display movie page sliver grid list and its items.',
      (WidgetTester tester) async {
    when(moviesCubit.state).thenReturn(
      PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies]),
    );

    when(moviesCubit.stream).thenAnswer(
      (_) => Stream.value(PopularMoviesLoadedState(
          popularMovies: [mockMovies, mockMovies, mockMovies])),
    );

    await tester.pumpWidget(buildMoviePage());
    await tester.pump();

    expect(find.byKey(moviePageSliverGridViewListKey), findsOneWidget);

    expect(find.byKey(moviePageSliverGridViewListItemKey(1)), findsOneWidget);
    expect(find.byKey(moviePageSliverGridViewListItemKey(2)), findsOneWidget);
  });
}
