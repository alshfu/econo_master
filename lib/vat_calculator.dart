import 'package:flutter/material.dart';

class VATCalculator extends StatefulWidget {
  @override
  _VATCalculatorState createState() => _VATCalculatorState();
}

class _VATCalculatorState extends State<VATCalculator> {
  final vatRateController = TextEditingController();
  final priceExVatController = TextEditingController();
  final vatAmountController = TextEditingController();
  final priceIncVatController = TextEditingController();

  double vatRate = 25.0; // Default VAT rate in %
  double priceExVat = 0.0;
  double vatAmount = 0.0;
  double priceIncVat = 0.0;

  bool calculateVatRate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: vatRateController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Enter VAT rate',
            ),
            onChanged: (value) {
              setState(() {
                vatRate = double.tryParse(value) ?? 25.0;
                if (!calculateVatRate) {
                  calculateValuesFromVatRateAndPriceExVat();
                }
              });
            },
          ),
          CheckboxListTile(
            title: const Text("Calculate VAT rate"),
            value: calculateVatRate,
            onChanged: (newValue) {
              setState(() {
                calculateVatRate = newValue!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          TextField(
            controller: priceExVatController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Enter price excluding VAT',
            ),
            onChanged: (value) {
              setState(() {
                priceExVat = double.tryParse(value) ?? 0.0;
                if (calculateVatRate) {
                  calculateVatRateFromValues();
                } else {
                  calculateValuesFromVatRateAndPriceExVat();
                }
              });
            },
          ),
          TextField(
            controller: vatAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'VAT amount',
            ),
            onChanged: (value) {
              setState(() {
                vatAmount = double.tryParse(value) ?? 0.0;
                if (calculateVatRate) {
                  calculateVatRateFromValues();
                } else {
                  calculateValuesFromVatAmount();
                }
              });
            },
          ),
          TextField(
            controller: priceIncVatController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Enter price including VAT',
            ),
            onChanged: (value) {
              setState(() {
                priceIncVat = double.tryParse(value) ?? 0.0;
                if (calculateVatRate) {
                  calculateVatRateFromValues();
                } else {
                  calculateValuesFromPriceIncVat();
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void calculateValuesFromVatRateAndPriceExVat() {
    vatAmount = priceExVat * vatRate / 100;
    priceIncVat = priceExVat + vatAmount;

    vatAmountController.text = vatAmount.toStringAsFixed(2);
    priceIncVatController.text = priceIncVat.toStringAsFixed(2);
  }

  void calculateValuesFromVatAmount() {
    priceExVat = vatAmount / (vatRate / 100);
    priceIncVat = priceExVat + vatAmount;

    priceExVatController.text = priceExVat.toStringAsFixed(2);
    priceIncVatController.text = priceIncVat.toStringAsFixed(2);
  }

  void calculateValuesFromPriceIncVat() {
    priceExVat = priceIncVat / (1 + vatRate / 100);
    vatAmount = priceIncVat - priceExVat;

    priceExVatController.text = priceExVat.toStringAsFixed(2);
    vatAmountController.text = vatAmount.toStringAsFixed(2);
  }

  void calculateVatRateFromValues() {
    if (priceExVat != 0 && vatAmount != 0) {
      vatRate = (vatAmount / priceExVat) * 100;
    } else if (priceExVat != 0 && priceIncVat != 0) {
      vatRate = ((priceIncVat - priceExVat) / priceExVat) * 100;
    } else if (vatAmount != 0 && priceIncVat != 0) {
      vatRate = (vatAmount / (priceIncVat - vatAmount)) * 100;
    }

    vatRateController.text = vatRate.toStringAsFixed(2);
  }
}
