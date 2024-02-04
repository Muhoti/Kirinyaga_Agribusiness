// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SearchSupervisor.dart';
import 'package:kirinyaga_agribusiness/Components/SuDrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
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
  String duration = 'Less than 5hrs';
  String subcounty = 'Mwea West';
  String ward = 'Mutithi';
  String targetFarmers = '';
  String error = '';
  var data;
  var isLoading;
  String check = '';
  String type = 'Office duty';
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
      Timer(const Duration(seconds: 2), () {
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
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "New Activity",
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
                            builder: (_) => const SupervisorHome()));
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(child: SuDrawer()),
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
                    MySelectInput(
                      title: "Duration",
                      onSubmit: (newValue) {
                        setState(() {
                          error = "";
                          duration = newValue;
                        });
                      },
                      entries: const ["Less than 5hrs", "Half Day", "Full Day"],
                      value: data == null ? "Less than 5hrs" : duration,
                    ),
                    MySelectInput(
                      title: "Activity Type",
                      onSubmit: (newValue) {
                        setState(() {
                          error = "";
                          type = newValue;
                        });
                      },
                      entries: const [
                        "Office duty",
                        "Workshop",
                        "Extension Services",
                        "Training",
                        "Other"
                      ],
                      value: data == null ? "Office duty" : type,
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
                        value:
                            data == null ? subcounty : data["Select County"]),
                    MySelectInput(
                        title: "Ward",
                        onSubmit: (value) {
                          setState(() {
                            ward = value;
                          });
                        },
                        entries: wrds,
                        value: data == null ? ward : data["Ward"]),
                    MyTextInput(
                      title: "Description",
                      value: description,
                      type: TextInputType.text,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          description = value;
                        });
                      },
                      lines: 5,
                    ),
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
                            type,
                            description,
                            duration,
                            subcounty,
                            ward,
                            Latitude,
                            Longitude,
                            widget.userid);

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
                                    builder: (context) =>
                                        const SupervisorHome()));
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
  String type,
  String description,
  String duration,
  String subcounty,
  String ward,
  double latitude,
  double longitude,
  String userid,
) async {
  if (task.isEmpty || type.isEmpty || description.isEmpty || duration.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
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
        'Type': type,
        'Description': description,
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
