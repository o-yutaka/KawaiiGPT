abstract class NotificationService {
  Future<void> requestPermission();
  Future<void> showLocal({required String title, required String body});
}

class StubNotificationService implements NotificationService {
  @override
  Future<void> requestPermission() async {}

  @override
  Future<void> showLocal({required String title, required String body}) async {}
}
