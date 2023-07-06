import 'package:flutter/material.dart';

class RUTCalculator extends StatefulWidget {
  @override
  _RUTCalculatorState createState() => _RUTCalculatorState();
}

class _RUTCalculatorState extends State<RUTCalculator> {
  final priceInkVatBeforeRutController = TextEditingController();
  final priceExVatBeforeRutController = TextEditingController();
  final rutAmountController = TextEditingController();
  final vatAmountController = TextEditingController();
  final priceAfterRutController = TextEditingController();

  void updateTextField(TextEditingController controller) {
    String text = controller.text;
    if (!text.contains('.')) {
      if (!text.endsWith('.00')) {
        text += '.00';
        controller.text = text;
      }
      controller.selection = TextSelection.collapsed(offset: text.length - 3);
    }
  }

  @override
  void initState() {
    super.initState();

    priceInkVatBeforeRutController.addListener(() {
      updateTextField(priceInkVatBeforeRutController);
    });

    priceExVatBeforeRutController.addListener(() {
      updateTextField(priceExVatBeforeRutController);
    });

    rutAmountController.addListener(() {
      updateTextField(rutAmountController);
    });

    vatAmountController.addListener(() {
      updateTextField(vatAmountController);
    });

    priceAfterRutController.addListener(() {
      updateTextField(priceAfterRutController);
    });
  }

  double priceInkVatBeforeRut = 0.0;
  double priceExVatBeforeRut = 0.0;
  double rutAmount = 0.0;
  double vatAmount = 0.0;
  double priceAfterRut = 0.0;
  double vatRate = 25.0 / 100; // Default VAT rate
  double rutRate = 50.0 / 100; // Default RUT rate

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          // Price before RUT inkl. vat TextField_A
          TextField(
            controller: priceInkVatBeforeRutController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Price before RUT inkl. vat',
            ),
            onChanged: (value) {
              setState(() {
                priceInkVatBeforeRut = double.tryParse(value) ?? 0.0;
                calculateField_BCDE();
              });
            },
          ),
          // Price before RUT ex. vat TextField_B
          TextField(
            controller: priceExVatBeforeRutController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Price before RUT ex. vat',
            ),
            onChanged: (value) {
              setState(() {
                priceExVatBeforeRut = double.tryParse(value) ?? 0.0;
                calculateField_ACDE();
              });
            },
          ),
          // VAT amount TextField_C
          TextField(
            controller: vatAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'VAT amount',
            ),
            onChanged: (value) {
              setState(() {
                vatAmount = double.tryParse(value) ?? 0.0;
                calculateField_ABDE();
              });
            },
          ),
          // Price after RUT TextField_D
          TextField(
            controller: priceAfterRutController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Price after RUT',
            ),
            onChanged: (value) {
              setState(() {
                priceAfterRut = double.tryParse(value) ?? 0.0;
                calculateField_ABCE();
              });
            },
          ),
          // RUT amount TextField_E
          TextField(
            controller: rutAmountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'RUT amount',
            ),
            onChanged: (value) {
              setState(() {
                rutAmount = double.tryParse(value) ?? 0.0;
                calculateField_ABCD();
              });
            },
          ),
        ],
      ),
    );
  }

  bool isCalculating = false;

// Vat rate is 25% in Sweden and RUT rate is 30% in Sweden

// Calculate Field_B (price before RUT ex.VAT), Field_C (VAT amount), Field_D (price after RUT), Field_E (RUT amount) from Field_A (price before RUT ink.VAT)
  void calculateField_BCDE() {
    if (isCalculating) {
      return;
    }
    isCalculating = true;
    priceExVatBeforeRut = priceInkVatBeforeRut / 1.25;
    vatAmount = priceInkVatBeforeRut - priceExVatBeforeRut;
    priceAfterRut = priceInkVatBeforeRut * 0.7;
    rutAmount = priceInkVatBeforeRut * 0.3;

    priceExVatBeforeRutController.text = priceExVatBeforeRut.toStringAsFixed(2);
    vatAmountController.text = vatAmount.toStringAsFixed(2);
    priceAfterRutController.text = priceAfterRut.toStringAsFixed(2);
    rutAmountController.text = rutAmount.toStringAsFixed(2);

    isCalculating = false;
  }

// Calculate Field_A (price before RUT ink.VAT), Field_C (VAT amount), Field_D (price after RUT), Field_E (RUT amount) from Field_B (price before RUT ex.VAT)
  void calculateField_ACDE() {
    if (isCalculating) {
      return;
    }
    isCalculating = true;
    priceInkVatBeforeRut = priceExVatBeforeRut * 1.25;
    vatAmount = priceInkVatBeforeRut - priceExVatBeforeRut;
    priceAfterRut = priceInkVatBeforeRut * 0.7;
    rutAmount = priceInkVatBeforeRut * 0.3;

    priceInkVatBeforeRutController.text =
        priceInkVatBeforeRut.toStringAsFixed(2);
    vatAmountController.text = vatAmount.toStringAsFixed(2);
    priceAfterRutController.text = priceAfterRut.toStringAsFixed(2);
    rutAmountController.text = rutAmount.toStringAsFixed(2);

    isCalculating = false;
  }

// Calculate Field_A (price before RUT ink.VAT), Field_B (price before RUT ex.VAT), Field_D (price after RUT), Field_E (RUT amount) from Field_C (VAT amount)
  void calculateField_ABDE() {
    if (isCalculating) {
      return;
    }
    isCalculating = true;

    priceExVatBeforeRut = vatAmount / vatRate;
    priceInkVatBeforeRut = priceExVatBeforeRut + vatAmount;
    priceAfterRut = priceInkVatBeforeRut * 0.7;
    rutAmount = priceInkVatBeforeRut - priceAfterRut;

    priceInkVatBeforeRutController.text =
        priceInkVatBeforeRut.toStringAsFixed(2);
    priceExVatBeforeRutController.text = priceExVatBeforeRut.toStringAsFixed(2);
    priceAfterRutController.text = priceAfterRut.toStringAsFixed(2);
    rutAmountController.text = rutAmount.toStringAsFixed(2);

    isCalculating = false;
  }

// Calculate Field_A (price before RUT inkl.VAT), Field_B (price before RUT ex.VAT), Field_C (VAT amount), Field_E (RUT amount) from Field_D (price after RUT)
  void calculateField_ABCE() {
    if (isCalculating) {
      return;
    }
    isCalculating = true;

    priceInkVatBeforeRut = priceAfterRut / 0.7;
    priceExVatBeforeRut = priceInkVatBeforeRut / 1.25;
    vatAmount = priceInkVatBeforeRut - priceExVatBeforeRut;
    rutAmount = priceInkVatBeforeRut - priceAfterRut;

    priceInkVatBeforeRutController.text = priceInkVatBeforeRut.toStringAsFixed(2);
    priceExVatBeforeRutController.text = priceExVatBeforeRut.toStringAsFixed(2);
    vatAmountController.text = vatAmount.toStringAsFixed(2);
    rutAmountController.text = rutAmount.toStringAsFixed(2);
    isCalculating = false;
  }

// Calculate Field_A (price before RUT inkl.VAT), Field_B (price before RUT ex.VAT), Field_C (VAT amount), Field_D (price after RUT) from Field_E (RUT amount)
  void calculateField_ABCD() {
    if (isCalculating) {
      return;
    }
    isCalculating = true;
    priceInkVatBeforeRut = rutAmount / 0.3;
    priceExVatBeforeRut = priceInkVatBeforeRut / 1.25;
    vatAmount = priceInkVatBeforeRut - priceExVatBeforeRut;
    priceAfterRut = priceInkVatBeforeRut * 0.7;

    priceInkVatBeforeRutController.text = priceInkVatBeforeRut.toStringAsFixed(2);
    priceExVatBeforeRutController.text = priceExVatBeforeRut.toStringAsFixed(2);
    vatAmountController.text = vatAmount.toStringAsFixed(2);
    priceAfterRutController.text = priceAfterRut.toStringAsFixed(2);
    isCalculating = false;
  }
}
