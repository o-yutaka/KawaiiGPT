import 'package:flutter_test/flutter_test.dart';
import 'package:near/core/near_policy.dart';
import 'package:near/core/near_safety.dart';

void main() {
  test('discovery radius is bounded', () {
    expect(NearPolicy.isAllowedRadius(1000), isTrue);
    expect(NearPolicy.isAllowedRadius(10001), isFalse);
  });

  test('external contact requires mutual connection and explicit action', () {
    expect(NearSafety.canExchangeExternalContact(mutualConnection: false, explicitUserAction: true), isFalse);
    expect(NearSafety.canExchangeExternalContact(mutualConnection: true, explicitUserAction: false), isFalse);
    expect(NearSafety.canExchangeExternalContact(mutualConnection: true, explicitUserAction: true), isTrue);
  });
}
