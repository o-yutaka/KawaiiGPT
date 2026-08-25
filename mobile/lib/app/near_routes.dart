import 'package:flutter/material.dart';
import '../features/chat/chat_screen.dart';
import '../features/connection/connection_screen.dart';
import '../features/nearby/nearby_screen.dart';
import '../features/now/now_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/safety/safety_screen.dart';

Route<dynamic>? nearRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/': return MaterialPageRoute(builder: (_) => const OnboardingScreen());
    case '/nearby': return MaterialPageRoute(builder: (_) => const NearbyScreen());
    case '/chat': return MaterialPageRoute(builder: (_) => const ChatScreen());
    case '/now': return MaterialPageRoute(builder: (_) => const NowScreen());
    case '/connection': return MaterialPageRoute(builder: (_) => const ConnectionScreen());
    case '/safety': return MaterialPageRoute(builder: (_) => const SafetyScreen());
  }
  return null;
}
