// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/FMItem.dart';
import 'package:kirinyaga_agribusiness/Components/FMSummary.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String name = '';
  String phone = '';
  String id = '';
  String user = '';
  var nationalId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Summary"),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 10,
                    child: FMItem(
                        title: "Current Farmer",
                        tally: 31226569,
                        icon: Icons.person_pin_circle_rounded,
                        user: "Crimson Sikolia"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                          title: "Farmer Info",
                          icon: Icons.person_2_rounded,
                          mapped: true)),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                          title: "Farmer Address",
                          icon: Icons.location_pin,
                          mapped: true)),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                          title: "Farm Resources",
                          icon: Icons.library_books,
                          mapped: true)),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                          title: "Farmer Groups",
                          icon: Icons.groups,
                          mapped: true)),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                          title: "Value Chains",
                          icon: Icons.agriculture,
                          mapped: false)),
                  SubmitButton(
                    label: "Finish",
                    onButtonPressed: () async {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const Home()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
