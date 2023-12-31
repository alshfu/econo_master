import 'package:flutter/material.dart';
import 'package:econo_master/localization.dart';

import 'vat_calculation.dart'; // Update the import

class CalculationHistoryTable extends StatefulWidget {
  final ValueNotifier<List<VATCalculation>> calculations;

  CalculationHistoryTable(this.calculations);

  @override
  _CalculationHistoryTableState createState() =>
      _CalculationHistoryTableState();
}

class _CalculationHistoryTableState extends State<CalculationHistoryTable>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // This ensures that the state is kept alive

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final loc = AppLocalizations.of(context);

    return ValueListenableBuilder<List<VATCalculation>>(
      valueListenable: widget.calculations,
      builder: (context, calculations, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text(loc.translate('price_before'))),
              DataColumn(label: Text(loc.translate('price_after'))),
              DataColumn(label: Text(loc.translate('vat'))),
              DataColumn(label: Text(loc.translate('vat_rate'))),
            ],
            rows: calculations.map((calculation) {
              return DataRow(
                color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (calculation.taxType == 'Incoming VAT')
                        return Colors.green.withOpacity(0.3);
                      if (calculation.taxType == 'Outgoing VAT')
                        return Colors.red.withOpacity(0.3);
                      return Colors.blue.withOpacity(0.3);
                    }),
                cells: [
                  DataCell(Text(calculation.id.toString())),
                  DataCell(Text(calculation.priceBefore.toStringAsFixed(2))),
                  DataCell(Text(calculation.priceAfter.toStringAsFixed(2))),
                  DataCell(Text(calculation.vat.toStringAsFixed(2))),
                  DataCell(Text(calculation.vatRate.toStringAsFixed(2))),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
