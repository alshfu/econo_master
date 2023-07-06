import 'package:flutter/material.dart';
import 'package:econo_master/rut_calculator.dart';
import 'package:econo_master/vat_calculator.dart';
import 'package:econo_master/about.dart';

class EconoMaster extends StatelessWidget {
  const EconoMaster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('EconoMaster'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'VAT Calculator'),
                Tab(text: 'RUT Calculator'),
                Tab(text: 'About')
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
