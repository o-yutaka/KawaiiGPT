enum ReportCategory { spam, harassment, scam, impersonation, unsafe, other }

class ModerationPolicy {
  static const maxMessagesPerMinute = 30;
  static const maxConnectionRequestsPerHour = 20;
  static const maxReportsPerHour = 20;

  static bool validMessage(String body) {
    final text = body.trim();
    return text.isNotEmpty && text.length <= 4000;
  }

  static bool validNow(String body) {
    final text = body.trim();
    return text.isNotEmpty && text.length <= 500;
  }
}
