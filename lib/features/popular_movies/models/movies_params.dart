/// The details of Movie Params.
class MovieParams {
  /// Constructs a new Movie Params.
  MovieParams(this.languageCode, this.page);

  /// Language code to retrieve relevant movies in that specific language.
  final String? languageCode;

  /// Determines which page user's currently in.
  final int page;
}