enum PaymentCardStyle {
  yellowish,
  blueish,
  trafficLightish,
}

enum PaymentCardProvider {
  invalidCard,
  huisa,
  disk,
}

class PaymentCardData {
  final double? balance;
  final String? ownerName;
  final PaymentCardStyle? style;
  final PaymentCardProvider? provider;

  const PaymentCardData({
    this.balance,
    this.ownerName,
    this.style,
    this.provider,
  });
}
