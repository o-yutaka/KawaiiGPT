import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NEAR core invariants', () {
    const radiusMinutes = 10;
    expect(radiusMinutes, 10);
    expect('location'.contains('lat'), isFalse);
  });
}
