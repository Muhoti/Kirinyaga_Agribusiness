// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Stats.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateWorkPlan.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/SupScrollController.dart';
import '../Components/NavigationButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Components/SuDrawer.dart';

class SupervisorHome extends StatefulWidget {
  const SupervisorHome({super.key});

  @override
  State<SupervisorHome> createState() => _SupervisorHomeState();
}

class _SupervisorHomeState extends State<SupervisorHome> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String total_farmers = '';
  String reached_farmers = '';
  String workplans = '';
  String active = 'Pending';
  String id = '';
  String status = 'Pending';

  String nationalId = '';

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  Future<void> getDefaultValues() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    if (decoded["error"] == "Invalid token") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      setState(() {
        name = decoded["Name"];
        id = decoded["UserID"];
      });
      countTasks(decoded["UserID"]);
    }
  }

  Future<void> countTasks(String id) async {
    try {
      final dynamic response;
      response = await http.get(
        Uri.parse("${getUrl()}workplan/stats/supervisor/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(response.body);

      setState(() {
        total_farmers = data["TotalFarmers"].toString();
        reached_farmers = data["ReachedFarmers"].toString();
        workplans = data["WorkPlan"].toString();
      });
    } catch (e) {}
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
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => CreateWorkPlan(
                          userid: id,
                        )));
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 32),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 233, 213),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(137, 158, 158, 158),
                        offset: Offset(2.0, 2.0), // Offset of the shadow
                        blurRadius: 5.0, // Blur radius of the shadow
                        spreadRadius: 2.0, // Spread radius of the shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          size: 84,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Duncan Muteti",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Phone: 0714816920",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                SizedBox(
                                  height: 6,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Station: Kutus offices",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))),
                                SizedBox(
                                  height: 6,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Location: Kirinyaga,Kutus",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)))
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "My Activities",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 100, 12),
              child: Container(
                height: 6,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 240, 240, 240),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(137, 158, 158, 158),
                        offset: Offset(2.0, 2.0), // Offset of the shadow
                        blurRadius: 5.0, // Blur radius of the shadow
                        spreadRadius: 2.0, // Spread radius of the shadow
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Row(children: [
                  Icon(
                    Icons.schedule,
                    color: Colors.orange,
                    size: 54,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                      child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Full Day Event",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Training at kirinyaga univeristy for Agriculture",
                            style: TextStyle(fontSize: 16),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "2024-2-4",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )),
                    ],
                  ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
