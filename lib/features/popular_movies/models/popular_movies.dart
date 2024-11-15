/// The information of popular movies.
class PopularMovies {
  /// Constructs a new [PopularMovies].
  PopularMovies({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  /// Indicates if the content is for adults only (e.g., 18+).
  final bool adult;

  /// The URL or path to the backdrop image for the content.
  final String? backdropPath;

  /// A list of genre IDs associated with the content.
  final List<int> genreIds;

  /// Unique identifier for the content.
  final int id;

  /// Original language of the content (e.g., "en" for English).
  final String originalLanguage;

  /// The original title of the content in its native language.
  final String originalTitle;

  /// Brief description or summary of the content.
  final String overview;

  /// Popularity score of the content based on user interactions.
  final double popularity;

  /// The URL or path to the poster image for the content.
  final String posterPath;

  /// Release date of the content in YYYY-MM-DD format.
  final String releaseDate;

  /// Display title of the content.
  final String title;

  /// Indicates if the content is a video.
  final bool video;

  /// Average user rating for the content (e.g., 7.5 out of 10).
  final double voteAverage;

  /// Total count of user votes for the content.
  final int voteCount;

  /// Generates a [PopularMovies] object from the given map.
  factory PopularMovies.fromMap(Map<String, dynamic> map) {
    return PopularMovies(
      adult: map['adult'] as bool,
      backdropPath: map['backdrop_path'] as String?,
      genreIds: (map['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: map['id'] as int,
      originalLanguage: map['original_language'] as String,
      originalTitle: map['original_title'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: map['poster_path'] as String,
      releaseDate: map['release_date'] as String,
      title: map['title'] as String,
      video: map['video'] as bool,
      voteAverage: map['vote_average'] as double,
      voteCount: map['vote_count'] as int,
    );
  }
}
