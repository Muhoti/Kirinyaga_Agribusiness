// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Model/WorkplanItem.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateActivity.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/SingleWP.dart';
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
  String phone = '';
  String station = '';
  String total_farmers = '';
  String reached_farmers = '';
  String workplans = '';
  String active = 'Pending';
  String id = '';
  String status = 'Pending';
  String nationalId = '';
  List<WorkplanItem> workplanItems = [];

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
      print(decoded);
      setState(() {
        name = decoded["Name"];
        phone = decoded["Phone"];
        station = decoded["Department"];
        id = decoded["UserID"];
      });
      getMyActivities(decoded["UserID"]);
    }
  }

  Future<void> getMyActivities(String id) async {
    try {
      final dynamic response;
      response = await http.get(
        Uri.parse("${getUrl()}activity/getmyactivities/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(response.body);
      print(data);
      setState(() {
        workplanItems = data
            .map<WorkplanItem>((json) => WorkplanItem(
                  json['Duration'],
                  json['Description'],
                  json['Task'],
                  json['SubCounty'],
                  json['Ward'],
                  json['createdAt'],
                  json['Latitude'],
                  json['Longitude'],
                  json['Type'],
                  json['ID'],
                ))
            .toList();
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
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_2_rounded,
                          size: 84,
                          color: Colors.orange,
                        ),
                        const SizedBox(
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
                                      "Phone: $phone",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Station: $station",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(
                                  height: 6,
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
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
              padding: const EdgeInsets.fromLTRB(16, 0, 100, 16),
              child: Container(
                height: 6,
                color: Colors.green,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: ListView.builder(
                itemCount: workplanItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SingleWP(
                                    item: workplanItems[index],
                                  )))
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 6, 24, 6),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 240, 240, 240),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(137, 158, 158, 158),
                                offset:
                                    Offset(2.0, 2.0), // Offset of the shadow
                                blurRadius: 5.0, // Blur radius of the shadow
                                spreadRadius:
                                    2.0, // Spread radius of the shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(children: [
                          const Icon(
                            Icons.schedule,
                            color: Colors.orange,
                            size: 54,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Flexible(
                              child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    workplanItems[index].Duration,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    workplanItems[index].Description,
                                    style: const TextStyle(fontSize: 16),
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "${workplanItems[index].Subcounty}, ${workplanItems[index].Ward}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    workplanItems[index].Date.split("T")[0],
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )),
                            ],
                          ))
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
