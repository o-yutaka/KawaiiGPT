enum Entitlement { free, plus, premium }

enum MonetizationEvent { adImpression, adClick, affiliateClick, affiliateConversion, subscriptionStarted, subscriptionCancelled }

class AffiliateOffer {
  final String id;
  final String title;
  final String destination;
  final String disclosure;
  const AffiliateOffer({required this.id, required this.title, required this.destination, this.disclosure = 'Affiliate'});
}

class PremiumState {
  final Entitlement entitlement;
  const PremiumState(this.entitlement);
  bool get isPaid => entitlement != Entitlement.free;
}
