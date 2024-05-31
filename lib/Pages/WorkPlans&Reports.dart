// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Stats.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateWorkPlan.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/FOScrollController.dart';
import '../Components/NavigationButton.dart';
import '../Components/FODrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkplansnReports extends StatefulWidget {
  const WorkplansnReports({super.key});

  @override
  State<WorkplansnReports> createState() => _WorkplansnReportsState();
}

class _WorkplansnReportsState extends State<WorkplansnReports> {
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
        Uri.parse("${getUrl()}workplan/stats/fieldofficer/$id"),
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
            "Workplan & Reports Stats",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const FieldOfficerHome()))
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: FODrawer()),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateWorkPlan(userid: id)));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(13, 50, 10, 1),
          ),
          child: const Text(
            'Create Workplan',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Target Farmers",
                          color: Colors.blue,
                          value: total_farmers,
                          icon: Icons.person_search,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Reached Farmers",
                          color: Colors.green,
                          value: reached_farmers,
                          icon: Icons.person_pin_circle,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Work Plans",
                          color: Colors.orange,
                          value: workplans,
                          icon: Icons.list_rounded,
                        )),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: NavigationButton(
                        label: "Pending",
                        active: active,
                        buttonPressed: () {
                          setState(() {
                            active = "Pending";
                            status = "Pending";
                            //countTasks(id);
                          });
                        },
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: NavigationButton(
                      label: "Complete",
                      active: active,
                      buttonPressed: () {
                        setState(() {
                          active = "Complete";
                          status = "Complete";
                          //countTasks(id);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: id != ""
                  ? FOScrollController(id: id, active: active, status: status)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
