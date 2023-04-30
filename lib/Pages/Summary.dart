// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FMItem.dart';
import 'package:kirinyaga_agribusiness/Components/FMSummary.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:http/http.dart' as http;
import '../Components/Utils.dart';

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
  var data = null;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    checkMapping();
    super.initState();
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      if (id != null) {
        searchMapped(id);
      }
    } catch (e) {}
  }

  searchMapped(id) async {
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}farmerdetails/mobile/forms/check/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var body = json.decode(response.body);
      print(body);
      setState(() {
        data = body;
      });
    } catch (e) {
      // todo
    }
  }

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
                onPressed: () => {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const Home()))
                },
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
                        title: data == null
                            ? "Farmer not found!"
                            : data["Data"]["Name"],
                        tally: data == null
                            ? 0
                            : int.parse(data["Data"]["NationalID"]),
                        icon: Icons.person_pin_circle_rounded,
                        user: data == null
                            ? "Farmer not found!"
                            : data["Data"]["User"]),
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
                        mapped: data == null ? false : data["FD"] > 0,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                        title: "Farmer Address",
                        icon: Icons.location_pin,
                        mapped: data == null ? false : data["FA"] > 0,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                        title: "Farm Resources",
                        icon: Icons.library_books,
                        mapped: data == null ? false : data["FR"] > 0,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                        title: "Farmer Groups",
                        icon: Icons.groups,
                        mapped: data == null ? false : data["FG"] > 0,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 5,
                      child: FMSummary(
                        title: "Value Chains",
                        icon: Icons.agriculture,
                        mapped: data == null ? false : data["VC"] > 0,
                      )),
                  SubmitButton(
                    label: "Finish",
                    onButtonPressed: () async {
                      if (data != null &&
                          data["FD"] > 0 &&
                          data["FA"] > 0 &&
                          data["FR"] > 0 &&
                          data["FG"] > 0 &&
                          data["VC"] > 0) {
                        storage.write(key: "NationalID", value: null);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const Home()));
                      }
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
