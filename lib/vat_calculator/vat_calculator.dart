import 'package:flutter/material.dart';
import 'info_display.dart';
import 'calculation_history_table.dart';
import 'vat_calculation.dart';
import 'package:econo_master/localization.dart';

class VATCalculator extends StatefulWidget {
  @override
  VATCalculatorState createState() => VATCalculatorState();
}

class VATCalculatorState extends State<VATCalculator> {
  final priceExVatController = TextEditingController();
  final vatAmountController = TextEditingController();
  final priceIncVatController = TextEditingController();

  double vatRate = 25.0; // Default VAT rate in %
  double priceExVat = 0.0;
  double vatAmount = 0.0;
  double priceIncVat = 0.0;

  double totalExVat = 0.0;
  double totalVatAmount = 0.0;
  double totalIncVat = 0.0;
  double totalIncomingVat = 0.0;
  double totalOutgoingVat = 0.0;

  double totalBeforeVatIn = 0.0;
  double totalAfterVatIn = 0.0;
  double totalVatIn = 0.0;

  double totalBeforeVatOut = 0.0;
  double totalAfterVatOut = 0.0;
  double totalVatOut = 0.0;

  double totalBeforeVatDiff = 0.0;
  double totalAfterVatDiff = 0.0;
  double totalVatDiff = 0.0;

  List<double> vatRates = [25.0, 12.0, 6.0];
  ValueNotifier<List<VATCalculation>> calculations = ValueNotifier<List<VATCalculation>>([]);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    priceExVatController.dispose();
    vatAmountController.dispose();
    priceIncVatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: DropdownButton<double>(
              alignment: Alignment.centerRight,
              value: vatRate,
              items: vatRates.map<DropdownMenuItem<double>>((double value) {
                return DropdownMenuItem<double>(
                  alignment: Alignment.centerRight,
                  value: value,
                  child: Text(
                    loc.translate('chose_your_vat_rate') + ' (${value.toStringAsFixed(0)} %)',
                  ),
                );
              }).toList()
                ..add(DropdownMenuItem(
                  alignment: Alignment.centerRight,
                  child: Text(loc.translate('enter_custom_VAT_rate_value')),
                  value: null,
                )),
              onChanged: (newValue) {
                if (newValue == null) {
                  showDialog<double>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(loc.translate('enter_custom_vat_value')),
                        content: TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          onSubmitted: (String value) {
                            double? customVatRate = double.tryParse(value);
                            if (customVatRate != null) {
                              Navigator.of(context).pop(customVatRate);
                            }
                          },
                        ),
                      );
                    },
                  ).then((double? customVatRate) {
                    if (customVatRate != null) {
                      setState(() {
                        if (!vatRates.contains(customVatRate)) {
                          vatRates.add(customVatRate);
                        }
                        vatRate = customVatRate;
                        calculateValuesFromVatRateAndPriceExVat();
                      });
                    }
                  });
                } else {
                  setState(() {
                    vatRate = newValue;
                    calculateValuesFromVatRateAndPriceExVat();
                  });
                }
              },
            ),
          ),
          TextField(
            controller: priceExVatController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: loc.translate('enter_price_excluding_vat'),
            ),
            onChanged: (value) {
              setState(() {
                priceExVat = double.tryParse(value) ?? 0.0;
                calculateValuesFromVatRateAndPriceExVat();
              });
            },
          ),
          TextField(
            controller: vatAmountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: loc.translate('vat_amount'),
            ),
            onChanged: (value) {
              setState(() {
                vatAmount = double.tryParse(value) ?? 0.0;
                calculateValuesFromVatAmount();
              });
            },
          ),
          TextField(
            controller: priceIncVatController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: loc.translate('enter_price_including_vat'),
            ),
            onChanged: (value) {
              setState(() {
                priceIncVat = double.tryParse(value) ?? 0.0;
                calculateValuesFromPriceIncVat();
              });
            },
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InfoDisplay(
                totalBeforeVatIn: totalBeforeVatIn,
                totalAfterVatIn: totalAfterVatIn,
                totalVatIn: totalVatIn,
                totalBeforeVatOut: totalBeforeVatOut,
                totalAfterVatOut: totalAfterVatOut,
                totalVatOut: totalVatOut,
                totalBeforeVatDiff: totalBeforeVatDiff,
                totalAfterVatDiff: totalAfterVatDiff,
                totalVatDiff: totalVatDiff,
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: addIncomingVat,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          'In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: addOutgoingVat,
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          'Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          CalculationHistoryTable(calculations),
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
    if (vatRate != -1.0) {
      priceExVat = vatAmount / (vatRate / 100);
      priceIncVat = priceExVat + vatAmount;

      priceExVatController.text = priceExVat.toStringAsFixed(2);
      priceIncVatController.text = priceIncVat.toStringAsFixed(2);
    }
  }

  void calculateValuesFromPriceIncVat() {
    if (vatRate != -1.0) {
      priceExVat = priceIncVat / (1 + vatRate / 100);
      vatAmount = priceIncVat - priceExVat;

      priceExVatController.text = priceExVat.toStringAsFixed(2);
      vatAmountController.text = vatAmount.toStringAsFixed(2);
    }
  }

  void addIncomingVat() {
    setState(() {
      totalIncomingVat += vatAmount;
      totalBeforeVatIn += priceExVat;
      totalAfterVatIn += priceIncVat;
      totalVatIn += vatAmount;

      totalBeforeVatDiff = totalBeforeVatIn - totalBeforeVatOut;
      totalAfterVatDiff = totalAfterVatIn - totalAfterVatOut;
      totalVatDiff = totalVatIn - totalVatOut;
    });
    addCalculation('Incoming VAT', vatAmount);
  }

  void addOutgoingVat() {
    setState(() {
      totalOutgoingVat += vatAmount;
      totalBeforeVatOut += priceExVat;
      totalAfterVatOut += priceIncVat;
      totalVatOut += vatAmount;

      totalBeforeVatDiff = totalBeforeVatIn - totalBeforeVatOut;
      totalAfterVatDiff = totalAfterVatIn - totalAfterVatOut;
      totalVatDiff = totalVatIn - totalVatOut;
    });
    addCalculation('Outgoing VAT', vatAmount);
  }

  void addCalculation(String taxType, double amount) {
    setState(() {
      calculations.value.add(
        VATCalculation(
          vatRate: vatRate,
          priceExVat: priceExVat,
          vatAmount: vatAmount,
          priceIncVat: priceIncVat,
          taxType: taxType,
          amount: amount,
          id: calculations.value.length,
          priceBefore: priceExVat,
          priceAfter: priceIncVat,
          vat: vatAmount,
        ),
      );
    });
  }
}
