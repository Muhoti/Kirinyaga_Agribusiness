// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SuDrawer.dart';
import 'package:kirinyaga_agribusiness/Model/WorkplanItem.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/SingleWP.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Components/Utils.dart';
import 'package:intl/intl.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  Color mpurple = const Color.fromRGBO(90, 66, 92, 1);
  int offset = 0;
  int ftotal = 0;
  int total = 1;
  int complete = 0;
  int pending = 0;
  String date = "";
  String month = "";
  bool checkedin = false;
  bool loading = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var workplanItems = [];
  final storage = const FlutterSecureStorage();
  String userid = "";
  String role = '';
  dynamic isLoading;

  @override
  initState() {
    super.initState();
    final now = DateTime.now();
    var dt = now.toIso8601String().split("-");
    var dt1 = "${dt[0]}-${dt[1]}";
    setState(() {
      date = "$dt1-01";
      month = DateFormat.yMMMMd('en_US').format(now);
    });
    getToken();
  }

  Future<void> getToken() async {
    try {
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());
      var expirationTime = decoded["exp"] ?? 0;

      if (expirationTime != 0 &&
          DateTime.now().millisecondsSinceEpoch > expirationTime * 1000) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Login()));
      } else {
        userid = decoded['UserID'];
        getWorkPlans(userid, offset * 5);
      }
    } catch (e) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    }
  }

  Future<void> getWorkPlans(String userid, int offset) async {
    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(
        Uri.parse("${getUrl()}activity/schedulepaginated/$userid/$offset"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print("schedule role: $userid, $offset");

      if (response.statusCode == 200 || response.statusCode == 203) {
        var body = jsonDecode(response.body);

        if (body["data"]?.length > 0) {
          var sf = body["data"]
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

          print("schedule data: $sf");

          setState(() {
            workplanItems = sf;
            total = (body["total"] / 5).ceil();
            ftotal = body["total"];
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });
        }
      } else {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant Schedule oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Schedule",
        home: Scaffold(
            key: _key,
            appBar: AppBar(
              title: const Text(
                "Activity Schedule",
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FieldOfficerHome()));
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
              backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            drawer: role == 'Supervisor'
                ? const Drawer(child: SuDrawer())
                : const Drawer(child: FODrawer()),
            body: Stack(children: [
              Column(children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                    child: loading
                        ? isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          )
                        : workplanItems.isNotEmpty
                            ? ListView.builder(
                                itemCount: workplanItems.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String date =
                                      workplanItems[index].Date.split("T")[0];

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
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 6, 24, 6),
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 240, 240, 240),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    137, 158, 158, 158),
                                                offset: Offset(2.0,
                                                    2.0), // Offset of the shadow
                                                blurRadius:
                                                    5.0, // Blur radius of the shadow
                                                spreadRadius:
                                                    2.0, // Spread radius of the shadow
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Row(children: [
                                          Icon(
                                            DateTime(
                                                        int.parse(
                                                            date.split("-")[0]),
                                                        int.parse(
                                                            date.split("-")[1]),
                                                        int.parse(
                                                            date.split("-")[2]))
                                                    .isAfter(DateTime.now())
                                                ? Icons.check
                                                : Icons.schedule,
                                            color: DateTime(
                                                        int.parse(
                                                            date.split("-")[0]),
                                                        int.parse(
                                                            date.split("-")[1]),
                                                        int.parse(
                                                            date.split("-")[2]))
                                                    .isAfter(DateTime.now())
                                                ? Colors.green
                                                : Colors.orange,
                                            size: 54,
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Flexible(
                                              child: Column(
                                            children: [
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    workplanItems[index].Task,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    workplanItems[index].Type,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "${workplanItems[index].Venue}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  )),
                                              Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    workplanItems[index]
                                                        .Date
                                                        .split("T")[0],
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  )),
                                            ],
                                          ))
                                        ]),
                                      ),
                                    ),
                                  );
                                })
                            : const SizedBox(
                                height: 250,
                                child: Center(
                                  child: Text(
                                    "No activities",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 24),
                                  ),
                                ),
                              ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            if (offset != 0) {
                              int v = (offset - 1) * 5;
                              setState(() {
                                offset = offset - 1;
                              });
                              getWorkPlans(userid, v);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: const Icon(
                              Icons.arrow_left,
                              size: 32,
                              color: Colors.white,
                            ),
                          )),
                      Text(
                        '${offset + 1}/$total',
                        style:
                            const TextStyle(color: Colors.green, fontSize: 20),
                      ),
                      TextButton(
                          onPressed: () {
                            if (offset + 1 < total) {
                              int v = (offset + 1) * 5;
                              setState(() {
                                offset = offset + 1;
                              });
                              getWorkPlans(userid, v);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24))),
                            child: const Icon(
                              Icons.arrow_right,
                              size: 32,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ]),
            ])));
  }
}
