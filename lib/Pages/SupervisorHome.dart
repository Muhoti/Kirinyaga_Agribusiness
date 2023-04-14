// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Stats.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/ScrollController.dart';
import '../Components/NavigationButton.dart';
import '../Components/NavigationDrawer2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupervisorHome extends StatefulWidget {
  const SupervisorHome({super.key});

  @override
  State<SupervisorHome> createState() => _FieldOfficerHomeState();
}

class _FieldOfficerHomeState extends State<SupervisorHome> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String total = '';
  String pending = '';
  String complete = '';
  String active = 'WorkPlan';
  String id = '';
  String status = 'Pending';

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  Future<void> getDefaultValues() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    if (decoded["error"] == "Invalid token") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Login()));
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

      active == "View Reports"
          ? response = await http.get(
              Uri.parse("${getUrl()}reports/stats/fieldofficer/$id"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            )
            
          : response = await http.get(
              Uri.parse("${getUrl()}workplan/stats/fieldofficer/$id"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            );

      print(response.body);
      print("this is being implemented");
      print("the id is $id");

      var data = json.decode(response.body);

      setState(() {
        total = data["total"].toString();
        pending = data["pending"].toString();
        complete = data["complete"].toString();
      });
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
          title: const Text("Supervisor Home"),
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
        drawer: const Drawer(child: NavigationDrawer2()),
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FarmerDetails()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(13, 50, 10, 1),
          ),
          child: const Text('Start Mapping!'),
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
                          label: "Work Plan",
                          color: Colors.blue,
                          value: total,
                          icon: Icons.trending_up,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Farmers",
                          color: Colors.orange,
                          value: pending,
                          icon: Icons.refresh,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Completed",
                          color: Colors.green,
                          value: complete,
                          icon: Icons.done,
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
                        label: "WorkPlan",
                        active: active,
                        buttonPressed: () {
                          setState(() {
                            active = "WorkPlan";
                            status = "Pending";
                            countTasks(id);
                            print("the count task is is $id");
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
                      label: "View Reports",
                      active: active,
                      buttonPressed: () {
                        setState(() {
                          active = "View Reports";
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
                  ? InfiniteScrollPaginatorDemo(
                      id: id, active: active, status: status)
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }
