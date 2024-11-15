import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/models/popular_movies.dart';
import 'package:flutter_bigpay_movie_app/features/popular_movies/repositories/popular_movies_repository.dart';
import 'package:flutter_bigpay_movie_app/keys/features/popular_movies/presentation/widgets/movie_card_keys.dart';
import 'package:get_it/get_it.dart';

/// Utilises this widget to display a movie poster.
class MovieCard extends StatefulWidget {
  /// Constructs a new [MovieCard].
  const MovieCard(this.movie, {super.key});

  /// Get the details of the movie.
  final PopularMovies? movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final PopularMoviesRepository popularMoviesRepository =
      GetIt.instance<PopularMoviesRepository>();

  late final String imageUrl;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    imageUrl = popularMoviesRepository.getMoviePosterUrl(
        moviePosterPath: widget.movie?.posterPath ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: movieCardContainerKey,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0.4,
            blurRadius: 3,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: imageUrl.isEmpty
          ? _buildCustomShimmerPlaceholder()
          : _buildImage(imageUrl),
    );
  }

  Widget _buildImage(String imageUrl) => CachedNetworkImage(
        key: movieCardImageKey,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (_, __, ___) => const Icon(Icons.error),
        placeholder: (_, __) => _buildCustomShimmerPlaceholder(),
      );

  Widget _buildCustomShimmerPlaceholder() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          key: movieCardShimmerPlaceholderKey,
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                max(0, _controller.value - 0.3),
                _controller.value,
                min(1, _controller.value + 0.3),
              ],
              colors: [
                Colors.grey.shade300,
                Colors.grey.shade100,
                Colors.grey.shade300,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
