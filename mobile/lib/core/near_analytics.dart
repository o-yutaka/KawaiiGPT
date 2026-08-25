class NearAnalytics {
  const NearAnalytics({this.sink = _noop});

  final void Function(String event, Map<String, Object?> properties) sink;

  void track(String event, [Map<String, Object?> properties = const {}]) {
    sink(event, properties);
  }

  static void _noop(String event, Map<String, Object?> properties) {}
}
