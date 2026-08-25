enum NearEvent { appOpened, onboardingCompleted, nearbyViewed, profileViewed, chatStarted, messageSent, nowViewed, nowCreated, connectionRequested, connectionAccepted, blocked, reported, inviteOpened }

class NearAnalytics {
  const NearAnalytics({this.sink = _noop});
  final void Function(String event, Map<String, Object?> properties) sink;

  void track(NearEvent event, [Map<String, Object?> properties = const {}]) => sink(event.name, properties);

  static void _noop(String event, Map<String, Object?> properties) {}
}
