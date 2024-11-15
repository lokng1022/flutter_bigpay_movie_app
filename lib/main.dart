import 'package:flutter/material.dart';
import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/presentation/pages/pages.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/states/popular_movies_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  configureDependencies();

  await GetIt.instance.allReady();

  await GetIt.instance<EnvironmentRepository>()
      .setAPIToken(envAPIToken: dotenv.env['API_KEY_AUTH'] ?? '');
  await GetIt.instance<EnvironmentRepository>()
      .setAccessToken(envAccessToken: dotenv.env['ACCESS_TOKEN_AUTH'] ?? '');

  await GetIt.instance<PopularMoviesRepository>().fetchMoviesList();

  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<PopularMoviesCubit>(
        create: (_) => PopularMoviesCubit(),
        child: const MoviePage(),
      ),
    );
  }
}
