import 'package:flutter/material.dart';

class InfoDisplay extends StatelessWidget {
  final double totalBeforeVatIn;
  final double totalAfterVatIn;
  final double totalVatIn;

  final double totalBeforeVatOut;
  final double totalAfterVatOut;
  final double totalVatOut;

  final double totalBeforeVatDiff;
  final double totalAfterVatDiff;
  final double totalVatDiff;

  InfoDisplay({
    required this.totalBeforeVatIn,
    required this.totalAfterVatIn,
    required this.totalVatIn,
    required this.totalBeforeVatOut,
    required this.totalAfterVatOut,
    required this.totalVatOut,
    required this.totalBeforeVatDiff,
    required this.totalAfterVatDiff,
    required this.totalVatDiff,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Category',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Total Before VAT',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Total VAT',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Total After VAT',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('IN VAT')),
            DataCell(Text('$totalBeforeVatIn')),
            DataCell(Text('$totalVatIn')),
            DataCell(Text('$totalAfterVatIn')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('OUT VAT')),
            DataCell(Text('$totalBeforeVatOut')),
            DataCell(Text('$totalVatOut')),
            DataCell(Text('$totalAfterVatOut')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('VAT Differences')),
            DataCell(Text('$totalBeforeVatDiff')),
            DataCell(Text('$totalVatDiff')),
            DataCell(Text('$totalAfterVatDiff')),
          ],
        ),
      ],
    );
  }
}
