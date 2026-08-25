import 'package:flutter_test/flutter_test.dart';
import '../lib/core/near_app_services.dart';

void main() {
  test('stub services provide deterministic offline behavior', () async {
    final services = NearAppServices.stub();
    final session = await services.auth.signInAnonymously();
    final location = await services.location.current();

    expect(session.userId, isNotEmpty);
    expect(location.latitude, inInclusiveRange(-90, 90));
    expect(location.longitude, inInclusiveRange(-180, 180));

    await services.auth.signOut();
    expect(await services.auth.currentSession(), isNull);
  });
}
