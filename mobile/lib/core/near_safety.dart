class NearSafety {
  static bool canExchangeExternalContact({required bool mutualConnection, required bool explicitUserAction}) => mutualConnection && explicitUserAction;

  static const int maxMessageLength = 4000;
  static const int maxReportLength = 1000;

  static String sanitizeMessage(String input) => input.trim().substring(0, input.trim().length > maxMessageLength ? maxMessageLength : input.trim().length);
}
