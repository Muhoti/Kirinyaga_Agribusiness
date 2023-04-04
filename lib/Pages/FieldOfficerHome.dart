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

class FieldOfficerHome extends StatefulWidget {
  const FieldOfficerHome({super.key});

  @override
  State<FieldOfficerHome> createState() => _FieldOfficerHomeState();
}

class _FieldOfficerHomeState extends State<FieldOfficerHome> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String total = '';
  String pending = '';
  String complete = '';
  String active = 'Pending';
  String status = 'In Progress';
  String id = '';

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

      print("the id is $id and name is $name");
      countTasks(decoded["UserID"]);
    }
  }

  Future<void> countTasks(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}reports/fieldofficer/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      print("this is being implemented");
      print("the id is $id");

      var data = json.decode(response.body);

      print("the data is $data");
      setState(() {
        total = data["total"].toString();
        pending = data["pending"].toString();
        complete = data["complete"].toString();
      });

      print(
          "the total is $total, completed are $complete, and pending is $pending");
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
          title: const Text("Field Officer Home"),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: Colors.green,
        ),
        drawer: const Drawer(child: NavigationDrawer2()),
        body: Column(
          children: <Widget>[
            const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Text(
                      "Welcome",
                      style: TextStyle(fontSize: 24, color: Colors.blue),
                    ))),
            const SizedBox(height: 15),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      "$name, Below is your tasks profile:",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Total",
                          image: 'assets/images/stat1.png',
                          value: total,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Pending",
                          image: 'assets/images/stat2.png',
                          value: pending,
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Stats(
                          label: "Completed",
                          image: 'assets/images/stat3.png',
                          value: complete,
                        )),
                  ],
                )),
            const SizedBox(height: 15),
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
                            active = "Pending";
                            status = "In Progress";
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
                          active = "Completed";
                          status = "Resolved";
                        });
                      },
                    ),
                  ),
                  // id != ''
                  //     ? Flexible(
                  //         flex: 1,
                  //         fit: FlexFit.tight,
                  //         child: InfiniteScrollPaginatorDemo(
                  //           id: id,
                  //           status: status,
                  //           active: active,
                  //         ))
                  //     : const SizedBox(
                  //         height: 12,
                  //       ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
            // scrollable list of work plan
            id != ''
                ? Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: InfiniteScrollPaginatorDemo(
                        id: id, status: status, active: active),
                  )
                : const SizedBox(),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FarmerDetails()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Start Mapping!'),
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
