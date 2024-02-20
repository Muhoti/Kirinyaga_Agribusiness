// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyCalendar.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SearchSupervisor.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FOWorkPlanStats.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class CreateWorkPlan extends StatefulWidget {
  final String userid;
  const CreateWorkPlan({
    super.key,
    required this.userid,
  });

  @override
  State<CreateWorkPlan> createState() => _FarmerResourcesState();
}

class _FarmerResourcesState extends State<CreateWorkPlan> {
  String task = '';
  String date = '';
  String servicetype = '';
  String subcounty = '';
  String ward = '';
  String targetFarmers = '';
  String supervisor = '';
  String error = '';
  var data = null;
  var isLoading;
  String check = '';
  String Tally = '';
  String Phone = '';
  String Name = '';
  String SupervisorID = '';
  String role = 'Supervisor';

  final storage = const FlutterSecureStorage();
  List<String> wrds = ["Mutithi", "Kangai", "Thiba", "Wamumu"];
  List<SearchSupervisor> entries = <SearchSupervisor>[];

  var subc = {
    "Mwea West": ["Mutithi", "Kangai", "Thiba", "Wamumu"],
    "Mwea East": ["Nyangati", "Murinduko", "Gathigiriri", "Tebere"],
    "Kirinyaga East": [
      "Kabare",
      "Baragwi",
      "Njukiine",
      "Ngariama",
      "Karumandi"
    ],
    "Kirinyaga West": ["Mukure", "Kiine", "Kariti"],
    "Kirinyaga Central": ["Mutira", "Kanyekini", "Kerugoya", "Inoi"]
  };

  @override
  void initState() {
    super.initState();
  }

  updateWards(v) {
    setState(() {
      ward = subc[v]!.toList()[0];
      wrds = subc[v]!.toList();
    });
  }

  searchSupervisor(q) async {
    setState(() {
      entries.clear();
    });

    try {
      final response = await http.get(
          Uri.parse("${getUrl()}mobile/seachbyphone/$role/$q"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var data = json.decode(response.body);

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(
              SearchSupervisor(item["Name"], item["Phone"], item["UserID"]));
        }
      });
    } catch (e) {
      // todo
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Create Workplan", style: TextStyle(color: Colors.white),),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const FOWorkPlanStats()))
                },
                icon: const Icon(Icons.arrow_back, color: Colors.white,),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    MyTextInput(
                      title: "Task Name",
                      lines: 1,
                      value: task,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          task = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCalendar(
                      label: "Select date",
                      onSubmit: (value) {
                        setState(() {
                          date = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                      title: "Service Type",
                      onSubmit: (newValue) {
                        setState(() {
                          error = "";
                          servicetype = newValue;
                        });
                      },
                      entries: const ["Extension Service", "Training", "Other"],
                      value: data == null ? "Extension Service" : servicetype,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Sub County",
                        onSubmit: (value) {
                          setState(() {
                            subcounty = value;
                          });
                          updateWards(value);
                        },
                        entries: subc.keys.toList(),
                        value: data == null ? subcounty : data["Select County"]),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Ward",
                        onSubmit: (value) {
                          setState(() {
                            ward = value;
                          });
                        },
                        entries: wrds,
                        value: data == null ? ward : data["Ward"]),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                      title: "Target Farmers",
                      lines: 1,
                      value: targetFarmers,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          targetFarmers = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Phone.isNotEmpty ? 
                    MyTextInput(
                      title: "Supervisor",
                      lines: 1,
                      value: Phone,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          Phone = value;
                        });
                      },
                    ) :
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextFormField(
                          onChanged: (value) {
                            if (value.characters.length >=
                                check.characters.length) {
                              searchSupervisor(value);
                            } else {
                              setState(() {
                                entries.clear();
                                Tally = '';
                                Phone = '';
                                Name = '';
                                SupervisorID = '';
                              });
                            }
                            setState(() {
                              check = value;
                              error = '';
                            });
                          },
                          keyboardType: TextInputType.number,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(24, 8, 24, 0))),
                              filled: false,
                              label: Text(
                                "Search Supervisor by Phone Number",
                                style:
                                    TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always)),
                    ),
                    entries.isNotEmpty
                        ? Card(
                            elevation: 12,
                            child: ListView.separated(
                              padding: const EdgeInsets.all(4),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: entries.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                  onPressed: () {
                                    setState(() {
                                      Phone = entries[index].Phone;
                                      Name = entries[index].Name;
                                      SupervisorID = entries[index].SupervisorID;
                                      Tally = '1';
                                      entries.clear();
                                    });
                                  },
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          'Name: ${entries[index].Name}, Phone: ${entries[index].Phone}')),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                            ),
                          )
                        : const SizedBox(),
                    TextOakar(label: error),
                    SubmitButton(
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          error = "";
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });
                        var res = await submitData(
                          task,
                          date,
                          servicetype,
                          subcounty,
                          ward,
                          targetFarmers,
                          SupervisorID,
                          widget.userid,
                        );
                        print("new workplan details:");
      
                        setState(() {
                          isLoading = null;
                          if (res.error == null) {
                            error = res.success;
                          } else {
                            error = res.error;
                          }
                        });
      
                        if (res.error == null) {
                          Timer(const Duration(seconds: 2), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FOWorkPlanStats()));
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: isLoading,
            )
          ],
        ),
      ),
    );
  }
}

Future<Message> submitData(
  String task,
  String date,
  String servicetype,
  String subcounty,
  String ward,
  String targetFarmers,
  String supID,
  String userid,
) async {
  if (task.isEmpty) {
    return Message(token: null, success: null, error: "Task cannot be empty!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;

    response = await http.post(
      Uri.parse("${getUrl()}workplan/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!
      },
      body: jsonEncode(<String, String>{
        'Task': task,
        'Date': date,
        'SubCounty': subcounty,
        'Ward': ward,
        'Target': targetFarmers,
        'UserID': userid,
        'SupervisorID': supID,
        'Type': servicetype,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      return Message(
        token: null,
        success: null,
        error: "Connection to server failed!",
      );
    }
  } catch (e) {
    return Message(
      token: null,
      success: null,
      error: "Connection to server failed!",
    );
  }
}

class Message {
  var token;
  var success;
  var error;

  Message({
    required this.token,
    required this.success,
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      token: json['token'],
      success: json['success'],
      error: json['error'],
    );
  }
}
