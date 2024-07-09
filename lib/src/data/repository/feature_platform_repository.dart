abstract class FeaturePlatformRepository {
  Future<String> getUserAgent();
  Future<String> getDeviceId();
}