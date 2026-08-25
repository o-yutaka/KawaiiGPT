import 'auth_service.dart';
import 'location_service.dart';
import 'notification_service.dart';
import 'realtime_contract.dart';

class NearAppServices {
  final AuthService auth;
  final LocationService location;
  final NotificationService notifications;
  final RealtimeClient realtime;

  const NearAppServices({
    required this.auth,
    required this.location,
    required this.notifications,
    required this.realtime,
  });

  factory NearAppServices.stub() => const NearAppServices(
        auth: StubAuthService(),
        location: StubLocationService(),
        notifications: StubNotificationService(),
        realtime: StubRealtimeClient(),
      );
}
