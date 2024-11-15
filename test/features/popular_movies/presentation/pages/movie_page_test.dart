// import 'package:flutter/material.dart';
// import 'package:flutter_bigpay_movie_app/core/utils/constant/app_constant.dart';
// import 'package:flutter_bigpay_movie_app/features/popular_movies/presentation/pages/movie_page.dart';
// import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
// import 'package:flutter_bigpay_movie_app/features/popular_movies/states/popular_movies_cubit.dart';
// import 'package:flutter_bigpay_movie_app/keys/features/popular_movies/presentation/pages/movies_page_keys.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mockito/mockito.dart';
//
// import '../../../../di/generated_mocks.mocks.dart';
// import '../../../../mocks/popular_movies_mocks.dart';
//
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//
//   late PopularMoviesCubit moviesCubit;
//   late PopularMoviesRepository popularMoviesRepository;
//
//   setUpAll(() {
//     moviesCubit = MockPopularMoviesCubit();
//     popularMoviesRepository = MockPopularMoviesRepository();
//
//     GetIt.instance.registerSingleton(popularMoviesRepository);
//
//     const String posterPath = "/epsz7OqjwmeK1ehItgz1OVzxOH9.jpg";
//     const String posterUrl = moviePosterPrefixUrl + posterPath;
//
//     when(popularMoviesRepository.getMoviePosterUrl(moviePosterPath: posterPath))
//         .thenAnswer((_) => posterUrl);
//
//     when(moviesCubit.state).thenReturn(
//       PopularMoviesLoadedState(
//           popularMovies: [mockMovies, mockMovies, mockMovies]),
//     );
//
//     when(moviesCubit.stream).thenAnswer(
//       (_) => Stream.value(PopularMoviesLoadedState(
//           popularMovies: [mockMovies, mockMovies, mockMovies])),
//     );
//   });
//
//   Widget buildMoviePage() => MaterialApp(
//         home: BlocProvider<PopularMoviesCubit>(
//           create: (_) => moviesCubit,
//           child: const MoviePage(),
//         ),
//       );
//
//   testWidgets('should display movie page.', (WidgetTester tester) async {
//     await tester.pumpWidget(buildMoviePage());
//     await tester.pump(const Duration(milliseconds: 500));
//
//     expect(find.byKey(moviePageScaffoldKey), findsOneWidget);
//   });
// }
