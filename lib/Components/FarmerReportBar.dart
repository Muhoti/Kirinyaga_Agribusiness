import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/ReviewMap.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';

class FarmerReportBar extends StatefulWidget {
  final dynamic item;

  const FarmerReportBar({
    super.key,
    required this.item,
  });

  @override
  State<FarmerReportBar> createState() => _FarmerReportBar();
}

class _FarmerReportBar extends State<FarmerReportBar> {
  String my = '';
  var isLoading;
  var storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var farmerid = widget.item["NationalID"];

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    colors: [Colors.green, Color.fromARGB(255, 29, 221, 163)],
                  ),
                ),
                child: Column(children: [
                  const Text(
                    "Farmer Details",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name: " + widget.item["Name"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "National ID: " + widget.item["NationalID"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone: " + widget.item["Phone"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age Group: " + widget.item["AgeGroup"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    colors: [Colors.green, Color.fromARGB(255, 29, 221, 163)],
                  ),
                ),
                child: Column(children: [
                  const Text(
                    "Farmer Address",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name: " + widget.item["Name"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "National ID: " + widget.item["NationalID"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone: " + widget.item["Phone"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age Group: " + widget.item["AgeGroup"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    colors: [Colors.green, Color.fromARGB(255, 29, 221, 163)],
                  ),
                ),
                child: Column(children: [
                  const Text(
                    "Farmer Resources",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name: " + widget.item["Name"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "National ID: " + widget.item["NationalID"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Phone: " + widget.item["Phone"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Age Group: " + widget.item["AgeGroup"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 15),
            SubmitButton(
              label: "Update ValueChain",
              onButtonPressed: () async {
                setState(() {
                  storage.write(key: "NationalID", value: farmerid);
                });

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FarmerValueChains()));
              },
            ),
          ],
        ));
  }
}
