class VATCalculation {
  final int id;
  final double vatRate;
  final double priceExVat;
  final double vatAmount;
  final double priceIncVat;
  final String taxType;
  final double amount;
  final double priceBefore;
  final double priceAfter;
  final double vat;

  VATCalculation({
    required this.id,
    required this.vatRate,
    required this.priceExVat,
    required this.vatAmount,
    required this.priceIncVat,
    required this.taxType,
    required this.amount,
    required this.priceBefore,
    required this.priceAfter,
    required this.vat,
  });
}
