class NearPolicy {
  static const int discoveryRadiusMeters = 1000;
  static const int maxDiscoveryRadiusMeters = 10000;
  static const Duration recentHereWindow = Duration(minutes: 10);
  static const Duration nowLifetime = Duration(hours: 24);

  static bool isAllowedRadius(int meters) => meters > 0 && meters <= maxDiscoveryRadiusMeters;
}
