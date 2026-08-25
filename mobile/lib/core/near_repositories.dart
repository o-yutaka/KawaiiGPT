import 'near_models.dart';

abstract interface class NearbyRepository {
  Future<List<NearUser>> closestFirst({required double lat, required double lon, int radiusMeters = 1000});
}

abstract interface class ChatRepository {
  Stream<List<NearMessage>> watchMessages(String conversationId);
  Future<void> sendMessage(String conversationId, String body);
}

abstract interface class NowRepository {
  Stream<List<NowPost>> watchNearby();
  Future<void> create(String text);
}

abstract interface class ConnectionRepository {
  Future<ConnectionStateKind> request(String userId);
  Future<ConnectionStateKind> respond(String userId, bool accept);
}

class MockNearbyRepository implements NearbyRepository {
  @override
  Future<List<NearUser>> closestFirst({required double lat, required double lon, int radiusMeters = 1000}) async => const [
        NearUser(id: 'demo-1', name: 'Mika', age: 25, distanceMeters: 120, activity: 'LIVE', verified: true),
        NearUser(id: 'demo-2', name: 'Ren', age: 27, distanceMeters: 240, activity: 'JUST NOW'),
      ];
}
