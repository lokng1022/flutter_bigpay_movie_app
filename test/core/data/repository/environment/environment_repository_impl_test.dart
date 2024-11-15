import 'package:flutter_bigpay_movie_app/core/data/repository/environment/environment_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EnvironmentRepositoryImpl environmentRepositoryImpl;

  const String apiToken = 'api1234';
  const String accessToken = 'access1234';

  setUpAll(() {
    environmentRepositoryImpl = EnvironmentRepositoryImpl();

    environmentRepositoryImpl.setAPIToken(envAPIToken: apiToken);
    environmentRepositoryImpl.setAccessToken(envAccessToken: accessToken);
  });

  test('should retrieve api token when we call getAPIToken.', () {
    final String? result = environmentRepositoryImpl.getAPIToken();

    expect(result, apiToken);
  });

  test('should retrieve access token when we call getAccessToken.', () {
    final String? result = environmentRepositoryImpl.getAccessToken();

    expect(result, accessToken);
  });
}
