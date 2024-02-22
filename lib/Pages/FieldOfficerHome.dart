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
import 'package:kirinyaga_agribusiness/Pages/Schedule.dart';
import 'package:kirinyaga_agribusiness/Pages/SingleWP.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';

import '../Components/SuDrawer.dart';

class FieldOfficerHome extends StatefulWidget {
  const FieldOfficerHome({super.key});

  @override
  State<FieldOfficerHome> createState() => _FieldOfficerHomeState();
}

class _FieldOfficerHomeState extends State<FieldOfficerHome> {
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
  List<WorkplanItem> workplanItems = [];

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  Future<void> getDefaultValues() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    print(decoded);

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
                  json['Venue'],
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
        drawer: const Drawer(child: FODrawer()),
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
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Positioned(child: extendAppBar()),
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: displayUserInfo(),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const Schedule(), // Replace with the page you want to navigate to
                            ));
                          },
                          child: const MyRow(
                            no: '1',
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
                                        const FOWorkPlanStats(), // Replace with the page you want to navigate to
                                  ));
                                },
                                child: const MyRowIII(
                                    no: '6',
                                    title: 'Work Plans',
                                    image: 'assets/images/extserv.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: const MyRowIII(
                                    no: '7',
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
                                  Navigator.pop(context);
                                },
                                child: const MyRowIII(
                                    no: '6',
                                    title: 'Update',
                                    image: 'assets/images/myactivity.png'),
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
                                child: const MyRowIII(
                                    no: '7',
                                    title: 'Map',
                                    image: 'assets/images/myactivity.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // const Padding(
                  //   padding: EdgeInsets.all(16),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Text(
                  //       "My Activities",
                  //       style: TextStyle(
                  //           color: Colors.green,
                  //           fontSize: 28,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(16, 0, 100, 16),
                  //   child: Container(
                  //     height: 6,
                  //     color: Colors.green,
                  //   ),
                  // ),
                  // Flexible(
                  //   flex: 1,
                  //   fit: FlexFit.tight,
                  //   child: ListView.builder(
                  //     itemCount: workplanItems.length,
                  //     itemBuilder: (context, index) {
                  //       return GestureDetector(
                  //         onTap: () => {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (_) => SingleWP(
                  //                         item: workplanItems[index],
                  //                       )))
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.fromLTRB(16, 6, 24, 6),
                  //           child: Container(
                  //             padding: const EdgeInsets.all(12),
                  //             decoration: const BoxDecoration(
                  //                 color: Color.fromARGB(255, 240, 240, 240),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Color.fromARGB(137, 158, 158, 158),
                  //                     offset:
                  //                         Offset(2.0, 2.0), // Offset of the shadow
                  //                     blurRadius: 5.0, // Blur radius of the shadow
                  //                     spreadRadius:
                  //                         2.0, // Spread radius of the shadow
                  //                   ),
                  //                 ],
                  //                 borderRadius: BorderRadius.all(Radius.circular(5))),
                  //             child: Row(children: [
                  //               const Icon(
                  //                 Icons.schedule,
                  //                 color: Colors.orange,
                  //                 size: 54,
                  //               ),
                  //               const SizedBox(
                  //                 width: 12,
                  //               ),
                  //               Flexible(
                  //                   child: Column(
                  //                 children: [
                  //                   Align(
                  //                       alignment: Alignment.centerRight,
                  //                       child: Text(
                  //                         workplanItems[index].Task,
                  //                         style: const TextStyle(
                  //                             fontSize: 20,
                  //                             color: Colors.green,
                  //                             fontWeight: FontWeight.bold),
                  //                       )),
                  //                   Align(
                  //                       alignment: Alignment.centerRight,
                  //                       child: Text(
                  //                         workplanItems[index].Duration,
                  //                         style: const TextStyle(fontSize: 16),
                  //                       )),
                  //                   Align(
                  //                       alignment: Alignment.centerRight,
                  //                       child: Text(
                  //                         workplanItems[index].Venue,
                  //                         style: const TextStyle(
                  //                             fontSize: 12, color: Colors.grey),
                  //                       )),
                  //                   Align(
                  //                       alignment: Alignment.centerRight,
                  //                       child: Text(
                  //                         workplanItems[index].Date.split("T")[0],
                  //                         style: const TextStyle(
                  //                             fontSize: 12, color: Colors.grey),
                  //                       )),
                  //                 ],
                  //               ))
                  //             ]),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
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
        padding: EdgeInsets.all(50),
      ),
    );
  }

  Container displayUserInfo() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
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
          const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '1 Activity Today',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )),
        ],
      ),
    );
  }
}
