import 'package:injectable/injectable.dart';

import 'environment_repository.dart';

@Singleton(as: EnvironmentRepository)
class EnvironmentRepositoryImpl implements EnvironmentRepository {
  /// API token.
  late final String apiToken;

  /// Access token.
  late final String accessToken;

  @override
  String? getAPIToken() => apiToken;

  @override
  String? getAccessToken() => accessToken;

  @override
  Future<void> setAPIToken({required String envAPIToken}) async {
    apiToken = envAPIToken;
  }

  @override
  Future<void> setAccessToken({required String envAccessToken}) async {
    accessToken = envAccessToken;
  }
}
