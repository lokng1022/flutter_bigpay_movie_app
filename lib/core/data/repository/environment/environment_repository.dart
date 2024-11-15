/// Repository for managing environment variables.
abstract class EnvironmentRepository {
  /// Retrieves the api token set in environment.
  String? getAPIToken();

  /// Retrieves the api token set in environment.
  Future<void> setAPIToken({required String envAPIToken});

  /// Retrieves the access token set in environment.
  String? getAccessToken();

  /// Retrieves the access token set in environment.
  Future<void> setAccessToken({required String envAccessToken});
}
