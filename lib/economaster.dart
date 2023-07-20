import 'package:flutter/material.dart';
import 'package:econo_master/rut_calculator.dart';
import 'package:econo_master/vat_calculator/vat_calculator.dart';
import 'package:econo_master/about.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:econo_master/localization.dart';
import 'package:econo_master/vat_calculator/vat_calculation.dart';  // Import VATCalculation
import 'package:econo_master/vat_calculator/calculation_history_table.dart';  // Import CalculationHistoryTable

class EconoMaster extends StatefulWidget {
  const EconoMaster({Key? key}) : super(key: key);

  @override
  _EconoMasterState createState() => _EconoMasterState();
}

class _EconoMasterState extends State<EconoMaster> {
  final calculations = ValueNotifier<List<VATCalculation>>([]);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ru', ''),
      ],
      home: DefaultTabController(
        length: 4,  // Increase the length to 4
        child: Scaffold(
          appBar: AppBar(
            title: const Text('EconoMaster'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'VAT Calculator'),
                Tab(text: 'RUT Calculator'),
                Tab(text: 'About'),
                Tab(text: 'History'),  // Add a new tab
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  VATCalculator(),
                  RUTCalculator(),
                  const About(),
                  CalculationHistoryTable(calculations),  // Add a new tab view
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  transform: Matrix4.rotationZ(0.1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: const Text(
                    '(Beta)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const EconoMaster());
}
