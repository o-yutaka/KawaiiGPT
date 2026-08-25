import 'near_models.dart';

abstract interface class NearRepository {
  Future<List<NearUser>> nearbyUsers({
    required double latitude,
    required double longitude,
    int radiusMeters = 1000,
  });

  Stream<NearMessage> messages(String conversationId);

  Future<void> sendMessage({
    required String conversationId,
    required String body,
  });

  Stream<NowPost> nowPosts();

  Future<void> createNowPost(String text);
}

class UnconfiguredNearRepository implements NearRepository {
  const UnconfiguredNearRepository();

  @override
  Future<List<NearUser>> nearbyUsers({
    required double latitude,
    required double longitude,
    int radiusMeters = 1000,
  }) async => const [];

  @override
  Stream<NearMessage> messages(String conversationId) => const Stream.empty();

  @override
  Future<void> sendMessage({
    required String conversationId,
    required String body,
  }) async {}

  @override
  Stream<NowPost> nowPosts() => const Stream.empty();

  @override
  Future<void> createNowPost(String text) async {}
}
