class NearDeepLink {
  static String invite(String code) => 'near://invite/$code';
  static String profile(String userId) => 'near://user/$userId';
  static String now(String postId) => 'near://now/$postId';

  static String? inviteCode(String uri) {
    final value = uri.trim();
    const prefix = 'near://invite/';
    if (!value.startsWith(prefix)) return null;
    final code = value.substring(prefix.length);
    return code.isEmpty ? null : code;
  }
}
