enum RealtimeTopic { messages, nowPosts }

class RealtimeSubscription {
  final RealtimeTopic topic;
  final String scopeId;
  const RealtimeSubscription({required this.topic, required this.scopeId});
}

abstract class RealtimeClient {
  Stream<Map<String, Object?>> subscribe(RealtimeSubscription subscription);
  Future<void> close();
}

class StubRealtimeClient implements RealtimeClient {
  @override
  Stream<Map<String, Object?>> subscribe(RealtimeSubscription subscription) => const Stream.empty();

  @override
  Future<void> close() async {}
}
