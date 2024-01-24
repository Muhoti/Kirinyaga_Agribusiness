// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/MyCalendar.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextArea.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SearchSupervisor.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Model/SearchItem.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerGroups.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
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
  String description = '';
  String date = '';
  String duration = '';
  String subcounty = '';
  String ward = '';
  String targetFarmers = '';
  // String supervisor = '';
  String error = '';
  var data = null;
  var isLoading;
  String check = '';
  String Tally = '';
  String Phone = '';
  String Name = '';
  String SupervisorID = '';
  String role = 'Supervisor';
  double Latitude = 0.0;
  double Longitude = 0.0;

  late LocationPermission permission;

  late Position position;
  bool servicestatus = false;
  bool haspermission = false;
  String location = '';

  final storage = const FlutterSecureStorage();
  List<String> wrds = [];
  List<SearchSupervisor> entries = <SearchSupervisor>[];

  String getTodaysDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";
    setState(() {
      date = formattedDate;
    });
    return date;
  }

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

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Location is required! You will be logged out. Please turn on your location"),
      ));
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Login()));
      });
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Longitude = position.longitude;
    Latitude = position.latitude;

    setState(() {
      location = 'Current location Lat: $Latitude Lon: $Longitude';
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 1, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        Longitude = position.longitude;
        Latitude = position.latitude;
      });
    });
  }

  @override
  void initState() {
    checkGps();
    getTodaysDate();
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

      print("not searched also ${response.body}");

      var data = json.decode(response.body);
      print("supervisor data is $data");

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(
              SearchSupervisor(item["Name"], item["Phone"], item["UserID"]));
        }
      });
    } catch (e) {
      // todo
      print("not searched");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Create Task"),
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => FieldOfficerHome()));
            },
            icon: const Icon(Icons.arrow_back),
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
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
                  //   child: SizedBox(
                  //       height: 250,
                  //       child: MyMap(
                  //         lat: Latitude,
                  //         lon: Longitude,
                  //       )),
                  // ),
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
                  MyTextArea(
                    title: "Description",
                    value: description,
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        error = "";
                        description = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                    title: "Duration",
                    onSubmit: (newValue) {
                      setState(() {
                        error = "";
                        duration = newValue;
                      });
                    },
                    entries: const ["Less than 5hrs", "Half Day", "Full Day"],
                    value: data == null ? "Extension Service" : duration,
                  ),
                  // MySelectInput(
                  //   title: "Service Type",
                  //   onSubmit: (newValue) {
                  //     setState(() {
                  //       error = "";
                  //       servicetype = newValue;
                  //     });
                  //   },
                  //   entries: const ["Extension Service", "Training", "Other"],
                  //   value: data == null ? "Extension Service" : servicetype,
                  // ),
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
                  // MyTextInput(
                  //   title: "Target Farmers",
                  //   lines: 1,
                  //   value: targetFarmers,
                  //   type: TextInputType.number,
                  //   onSubmit: (value) {
                  //     setState(() {
                  //       error = "";
                  //       targetFarmers = value;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Phone.isNotEmpty ?
                  // MyTextInput(
                  //   title: "Supervisor",
                  //   lines: 1,
                  //   value: Phone,
                  //   type: TextInputType.number,
                  //   onSubmit: (value) {
                  //     setState(() {
                  //       error = "";
                  //       Phone = value;
                  //     });
                  //   },
                  // ) :
                  // Padding(
                  //   padding: const EdgeInsets.all(24.0),
                  //   child: TextFormField(
                  //       onChanged: (value) {
                  //         if (value.characters.length >=
                  //             check.characters.length) {
                  //           searchSupervisor(value);
                  //         } else {
                  //           setState(() {
                  //             entries.clear();
                  //             Tally = '';
                  //             Phone = '';
                  //             Name = '';
                  //             SupervisorID = '';
                  //           });
                  //         }
                  //         setState(() {
                  //           check = value;
                  //           error = '';
                  //         });
                  //       },
                  //       keyboardType: TextInputType.number,
                  //       enableSuggestions: false,
                  //       autocorrect: false,
                  //       decoration: const InputDecoration(
                  //           contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                  //           border: OutlineInputBorder(
                  //               borderSide: BorderSide(
                  //                   color: Color.fromRGBO(24, 8, 24, 0))),
                  //           filled: false,
                  //           label: Text(
                  //             "Search Supervisor by Phone Number",
                  //             style:
                  //                 TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                  //           ),
                  //           floatingLabelBehavior: FloatingLabelBehavior.always)),
                  // ),
                  // entries.isNotEmpty
                  //     ? Card(
                  //         elevation: 12,
                  //         child: ListView.separated(
                  //           padding: const EdgeInsets.all(4),
                  //           scrollDirection: Axis.vertical,
                  //           shrinkWrap: true,
                  //           itemCount: entries.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return TextButton(
                  //               onPressed: () {
                  //                 setState(() {
                  //                   Phone = entries[index].Phone;
                  //                   Name = entries[index].Name;
                  //                   SupervisorID = entries[index].SupervisorID;
                  //                   Tally = '1';
                  //                   entries.clear();
                  //                 });
                  //               },
                  //               child: Align(
                  //                   alignment: Alignment.centerLeft,
                  //                   child: Text(
                  //                       'Name: ${entries[index].Name}, Phone: ${entries[index].Phone}')),
                  //             );
                  //           },
                  //           separatorBuilder:
                  //               (BuildContext context, int index) =>
                  //                   const Divider(),
                  //         ),
                  //       )
                  //     : const SizedBox(),

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
                          description,
                          date,
                          duration,
                          subcounty,
                          ward,
                          Latitude,
                          Longitude,
                          widget.userid);
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
                                  builder: (context) => FieldOfficerHome()));
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
    );
  }
}

Future<Message> submitData(
  String task,
  String description,
  String date,
  String duration,
  String subcounty,
  String ward,
  double latitude,
  double longitude,
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
      body: jsonEncode(<String, dynamic>{
        'Task': task,
        'Description': description,
        'Date': date,
        'Duration': duration,
        'SubCounty': subcounty,
        'Latitude': latitude,
        'Longitude': longitude,
        'Ward': ward,
        'UserID': userid,
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
