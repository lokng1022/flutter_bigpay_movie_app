import 'package:flutter/material.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/models.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/presentation/widgets/movie_card.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/states/popular_movies_cubit.dart';
import 'package:flutter_bigpay_movie_app/keys/features/popular_movies/presentation/pages/movies_page_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Display a list of movies in [MoviePage].
class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final List<PopularMovies> _moviesList = <PopularMovies>[];

  @override
  void initState() {
    super.initState();

    _setScrollListener();
  }

  void _setScrollListener() => _scrollController.addListener(_onScroll);

  void _onScroll() {
    final PopularMoviesState moviesState =
        context.read<PopularMoviesCubit>().state;

    if (_shouldFetchMoreMovies(moviesState)) {
      _currentPage++;

      context.read<PopularMoviesCubit>().fetchPopularMovies(_currentPage);
    }
  }

  bool _shouldFetchMoreMovies(PopularMoviesState state) {
    const double scrollThreshold = 200;
    final double max = _scrollController.position.maxScrollExtent;
    final double current = _scrollController.position.pixels;

    return (max - current) <= scrollThreshold;
  }

  void _setPopularMoviesCubitListener(PopularMoviesState state) {
    if (state is PopularMoviesLoadedState) {
      _moviesList.addAll(state.popularMovies);
    } else if (state is PopularMoviesErrorState) {
      _showErrorDialog(state.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: moviePageScaffoldKey, body: _buildContent());
  }

  Widget _buildContent() {
    return BlocConsumer<PopularMoviesCubit, PopularMoviesState>(
      listenWhen: (previous, current) => previous != current,
      listener: (_, PopularMoviesState state) =>
          _setPopularMoviesCubitListener(state),
      builder: (_, state) {
        if (state is PopularMoviesLoadingState && _moviesList.isEmpty) {
          return const Center(
            key: moviePageLoadingIndicatorKey,
            child: CircularProgressIndicator(),
          );
        }

        return CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              key: moviePageAppbarKey,
              expandedHeight: 50.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Popular Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
              ),
            ),
            SliverGrid(
              key: moviePageSliverGridViewListKey,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, index) => MovieCard(
                  key: moviePageSliverGridViewListItemKey(index),
                  _moviesList[index],
                ),
                childCount: _moviesList.length,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          "Error",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              context
                  .read<PopularMoviesCubit>()
                  .fetchPopularMovies(_currentPage);
            },
            child: const Text("Retry"),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }
}
