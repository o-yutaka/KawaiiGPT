abstract class AuthService {
  Future<NearSession?> currentSession();
  Future<NearSession> signInAnonymously();
  Future<void> signOut();
}

class NearSession {
  final String userId;
  final String? accessToken;
  const NearSession({required this.userId, this.accessToken});
}

class StubAuthService implements AuthService {
  NearSession? _session;

  @override
  Future<NearSession?> currentSession() async => _session;

  @override
  Future<NearSession> signInAnonymously() async {
    _session ??= const NearSession(userId: 'local-user');
    return _session!;
  }

  @override
  Future<void> signOut() async {
    _session = null;
  }
}
