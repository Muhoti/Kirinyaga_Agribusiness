// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/MyRow.dart';
import 'package:kirinyaga_agribusiness/Components/MyRowIII.dart';
import 'package:kirinyaga_agribusiness/Components/SearchFarmer.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Model/WorkplanItem.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateActivity.dart';
import 'package:kirinyaga_agribusiness/Pages/FOWorkPlanStats.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/MyReports.dart';
import 'package:kirinyaga_agribusiness/Pages/MyWorkPlans.dart';
import 'package:kirinyaga_agribusiness/Pages/Schedule.dart';
import 'package:kirinyaga_agribusiness/Pages/SingleWP.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';

import '../Components/SuDrawer.dart';

class SupervisorHome extends StatefulWidget {
  const SupervisorHome({super.key});

  @override
  State<SupervisorHome> createState() => _SupervisorHomeState();
}

class _SupervisorHomeState extends State<SupervisorHome> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String phone = '';
  String station = '';
  String total_farmers = '';
  String reached_farmers = '';
  String workplans = '';
  String active = 'Pending';
  String id = '';
  String status = 'Pending';
  String nationalId = '';
  String formattedDate = '';
  String activities = '';
  String reports = '';
  String updates = '';
  String mapped = '';

  List stats = [];

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  Future<void> getDefaultValues() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    formattedDate = DateFormat('MMMM dd, yyyy').format(DateTime.now());
    print("date today: $formattedDate");
    if (decoded["error"] == "Invalid token") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      print(decoded);
      setState(() {
        name = decoded["Name"];
        phone = decoded["Phone"];
        station = decoded["Department"];
        id = decoded["UserID"];
      });

      fetchStats(decoded["UserID"]);
      getFarmersSectionStats(decoded["Name"]);
    }
  }

  Future<void> fetchStats(String id) async {
    try {
      final dynamic response;

      response = await http.get(
        Uri.parse("${getUrl()}workplan/stats/supervisor/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(response.body);
      print("stats $data");
      setState(() {
        activities = data["TotalOfficers"].toString();
        reports = data["Reports"].toString();
        workplans = data["WorkPlans"].toString();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFarmersSectionStats(user) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}farmerdetails/mapped/$user"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      var body = json.decode(response.body);
      var mystats = body;

      print("the body is $body");

      List<int> numbers = [
        body["FD"],
        body["FA"],
        body["FR"],
        body["FG"],
        body["VC"]
      ];
      int minimum = numbers.reduce(
        (currentMin, element) => element < currentMin ? element : currentMin,
      );
      print("Minimum: $minimum");

      setState(() {
        total_farmers = mystats["TF"].toString(); // Convert to string
        mapped = minimum.toString();
      });

      print("farmers stats: $total_farmers, $mapped");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(child: SuDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CreateActivity(
                          userid: id,
                        )));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(child: extendAppBar()),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                      child: displayUserInfo(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const Schedule(), // Replace with the page you want to navigate to
                            ));
                          },
                          child: MyRow(
                            no: activities,
                            title: 'My Activities',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Extension Services",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const MyWorkPlans(), // Replace with the page you want to navigate to
                                  ));
                                },
                                child: MyRowIII(
                                    no: workplans,
                                    title: 'Work Plans',
                                    image: 'assets/images/extserv.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const MyReports(), // Replace with the page you want to navigate to
                                  ));
                                },
                                child: MyRowIII(
                                    no: reports,
                                    title: 'Reports',
                                    image: 'assets/images/report.png'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Farmers Section",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SearchFarmer();
                                    },
                                  );
                                },
                                child: MyRowIII(
                                  no: total_farmers,
                                  title: 'Update',
                                  image: 'assets/images/updateFarm.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const Home(), // Replace with the page you want to navigate to
                                  ));
                                },
                                child: MyRowIII(
                                    no: mapped,
                                    title: 'Map',
                                    image: 'assets/images/mapIcon.png'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 48,
                        ),
                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              children: [
                                Text("KIRIAMIS",
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                Text("Staff App Module",
                                    style: TextStyle(
                                      fontSize: 14,
                                    )),
                              ],
                            ))
                      ],
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

  Container extendAppBar() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 128, 0, 1), // Set solid green color directly
      ),
      child: const Padding(
        padding: EdgeInsets.all(40),
      ),
    );
  }

  Container displayUserInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(137, 158, 158, 158),
              offset: Offset(2.0, 2.0),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Welcome",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800))),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            formattedDate,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  )),
              const SizedBox(
                width: 12,
              ),
              Image.asset(
                'assets/images/stat1.png', width: 84, // Set width of the image
                height: 84, // Set height of the image
                color: Colors.orange,
              )
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$activities Activity Today',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )),
        ],
      ),
    );
  }
}
