abstract class LocationService {
  Future<LocationSample> current();
}

class LocationSample {
  final double latitude;
  final double longitude;
  final double accuracyMeters;
  final DateTime capturedAt;

  const LocationSample({required this.latitude, required this.longitude, required this.accuracyMeters, required this.capturedAt});
}

class StubLocationService implements LocationService {
  final double latitude;
  final double longitude;

  const StubLocationService({this.latitude = 34.6937, this.longitude = 135.5023});

  @override
  Future<LocationSample> current() async => LocationSample(
        latitude: latitude,
        longitude: longitude,
        accuracyMeters: 25,
        capturedAt: DateTime.now().toUtc(),
      );
}
