class NearAttribution {
  final String? source;
  final String? campaign;
  final String? inviteCode;

  const NearAttribution({this.source, this.campaign, this.inviteCode});

  Map<String, String> toSafeMap() => {
        if (source != null) 'source': source!,
        if (campaign != null) 'campaign': campaign!,
        if (inviteCode != null) 'invite_code': inviteCode!,
      };
}
