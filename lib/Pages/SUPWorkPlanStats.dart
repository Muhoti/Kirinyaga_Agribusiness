// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Stats.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/SupScrollController.dart';
import '../Components/NavigationButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Components/SuDrawer.dart';

class SUPWorkPlanStats extends StatefulWidget {
  const SUPWorkPlanStats({super.key});

  @override
  State<SUPWorkPlanStats> createState() => _SUPWorkPlanStatsState();
}

class _SUPWorkPlanStatsState extends State<SUPWorkPlanStats> {
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
            "Supervisor WorkPlans",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: SuDrawer()),
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
                          label: "Assigned Officers",
                          color: Colors.blue,
                          value: total_farmers,
                          icon: Icons.person_search,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Reviewed Reports",
                          color: Colors.green,
                          value: reached_farmers,
                          icon: Icons.person_pin_circle,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Total Reports",
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
                            countTasks(id);
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
                          countTasks(id);
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
                  ? SupScrollController(id: id, active: active, status: status)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
