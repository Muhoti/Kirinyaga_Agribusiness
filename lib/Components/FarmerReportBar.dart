import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/ReviewMap.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';

class FarmerReportBar extends StatefulWidget {
  final dynamic fditem;
  final dynamic faitem;
  final dynamic fritem;
  final dynamic fgitem;
  final dynamic vcitem;

  const FarmerReportBar({
    super.key,
    required this.fditem,
    required this.faitem,
    required this.fritem,
    required this.fgitem,
    required this.vcitem,
  });

  @override
  State<FarmerReportBar> createState() => _FarmerReportBar();
}

class _FarmerReportBar extends State<FarmerReportBar> {
  String my = '';
   List<dynamic> fgitem2 = [];
   List<dynamic> vcitem2 = [];
  var isLoading;
  var storage = const FlutterSecureStorage();

  @override
  void initState() {
    var farmerid = widget.fditem["NationalID"];

   fgitem2 = widget.fgitem;
    vcitem2 = widget.vcitem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      "Name: " + widget.fditem["Name"],
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
                      "National ID: " + widget.fditem["NationalID"],
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
                      "Phone: " + widget.fditem["Phone"],
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
                      "Age Group: " + widget.fditem["AgeGroup"],
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
                      "County: " + widget.faitem["County"],
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
                      "SubCounty: " + widget.faitem["SubCounty"],
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
                      "Ward: " + widget.faitem["Ward"],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
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
                      "TotalAcreage: " + widget.fritem["TotalAcreage"],
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
                      "CropAcreage: ${widget.fritem["CropAcreage"]}",
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
                      "LivestockAcreage: ${widget.fritem["LivestockAcreage"]}",
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
                      "IrrigationType: ${widget.fritem["IrrigationType"]}",
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
                    "Farmer Groups",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: fgitem2?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        // Use null-aware operator (?) to check if fgitem2[index] is null
                        final group = fgitem2?[index];
                        if (group == null) {
                          return const SizedBox.shrink();
                        }
                        return ListTile(
                          title: Text(
                            "${group['Name']} - ${group['Type']}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        );
                      },
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
                    "Value Chains",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: vcitem2.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Use null-aware operator (?) to check if vcitem2[index] is null
                        final valueChain = vcitem2[index];
                        if (valueChain == null) {
                          return const SizedBox.shrink();
                        }
                        return ListTile(
                          title: Text(
                            "${valueChain['ValueChainName']}, LastHarvest - ${valueChain['PeriodEnd']}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }
}
