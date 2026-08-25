class NearUser {
  final String id;
  final String name;
  final int age;
  final int distanceMeters;
  final String activity;
  final String recentLabel;
  final List<String> interests;
  final bool verified;

  const NearUser({
    required this.id,
    required this.name,
    required this.age,
    required this.distanceMeters,
    required this.activity,
    this.recentLabel = '',
    this.interests = const [],
    this.verified = false,
  });
}

enum ConnectionStateKind { none, requested, mutual, externalContactUnlocked }

class NearMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String body;
  final DateTime createdAt;

  const NearMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.body,
    required this.createdAt,
  });
}

class NowPost {
  final String id;
  final String authorId;
  final String text;
  final DateTime createdAt;
  final DateTime expiresAt;

  const NowPost({
    required this.id,
    required this.authorId,
    required this.text,
    required this.createdAt,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
