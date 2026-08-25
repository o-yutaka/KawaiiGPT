class NearLocationPolicy {
  const NearLocationPolicy._();

  static const int discoveryRadiusMeters = 1000;
  static const int maxDiscoveryRadiusMeters = 10000;
  static const int recentHereWindowMinutes = 15;

  static bool withinDiscoveryRadius({
    required int distanceMeters,
    int radiusMeters = discoveryRadiusMeters,
  }) {
    final boundedRadius = radiusMeters.clamp(1, maxDiscoveryRadiusMeters);
    return distanceMeters <= boundedRadius;
  }

  static String recentLabel(Duration age) {
    final minutes = age.inMinutes;
    if (minutes < 2) return 'JUST NOW';
    if (minutes < recentHereWindowMinutes) return '${minutes}分前にこの周辺';
    return 'RECENT';
  }
}
