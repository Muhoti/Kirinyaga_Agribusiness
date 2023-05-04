// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, unnecessary_null_comparison, non_constant_identifier_names, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/counties.dart';
import '../Components/Utils.dart';
import '../Model/SubCounty.dart';
import 'Home.dart';

class FarmerAddress extends StatefulWidget {
  final bool editing;
  const FarmerAddress({super.key, required this.editing});

  @override
  State<FarmerAddress> createState() => _FarmerAddressState();
}

class _FarmerAddressState extends State<FarmerAddress> {
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
  List<String> wrds = [];
  String FarmerID = '';
  String SubCounty = '';
  String Ward = '';
  String Village = '';
  String error = '';
  String location = '';
  bool servicestatus = false;
  var isLoading;
  var data = null;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  double long = 0.0, lat = 0.0;
  late StreamSubscription<Position> positionStream;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    setState(() {
      var v = subc.keys.toList()[0];
      SubCounty = v;
      wrds = subc[v]!.toList();
      Ward = subc[v]!.toList()[0];
    });
    checkMapping();
    if (!widget.editing) {
      checkGps();
    } else {
      setState(() {
        location = 'Coordinates cannot be updated!. Contact adminstrator';
      });
    }
    super.initState();
  }

  updateWards(v) {
    setState(() {
      Ward = subc[v]!.toList()[0];
      wrds = subc[v]!.toList();
    });
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      if (id != null) {
        setState(() {
          FarmerID = id;
        });
        editFarmer(id);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Home()));
      }
    } catch (e) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Home()));
    }
  }

  editFarmer(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}farmeraddress/$id"),
      );

      var body = json.decode(response.body);

      if (body.length > 0) {
        updateWards(body[0]["SubCounty"]);
        setState(() {
          data = body[0];
          SubCounty = body[0]["SubCounty"];
          Ward = body[0]["Ward"];
          Village = body[0]["Village"];
          long = double.parse(body[0]["Longitude"]);
          lat = double.parse(body[0]["Latitude"]);
        });
      }
    } catch (e) {}
  }

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
    long = position.longitude;
    lat = position.latitude;
    setState(() {
      location = 'Current location Lat: $lat Lon: $long';
    });
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        long = position.longitude;
        lat = position.latitude;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Address"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()))
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: SizedBox(
                      height: 250,
                      child: MyMap(
                        lat: lat,
                        lon: long,
                      )),
                ),
                Text(location),
                const SizedBox(height: 24),
                MySelectInput(
                    title: "Sub County",
                    onSubmit: (value) {
                      setState(() {
                        SubCounty = value;
                      });
                      updateWards(value);
                    },
                    entries: subc.keys.toList(),
                    value: data == null ? SubCounty : data["SubCounty"]),
                const SizedBox(
                  height: 10,
                ),
                MySelectInput(
                    title: "Ward",
                    onSubmit: (value) {
                      setState(() {
                        Ward = value;
                      });
                    },
                    entries: wrds,
                    value: data == null ? Ward : data["Ward"]),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                    title: "Village",
                    value: Village,
                    lines: 1,
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        Village = value;
                      });
                    }),
                TextOakar(label: error),
                SubmitButton(
                  label: widget.editing ? "Update" : "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color.fromRGBO(0, 128, 0, 1),
                        size: 100,
                      );
                    });
                    var res = await submitData(widget.editing, FarmerID,
                        SubCounty, Ward, Village, lat, long);

                    setState(() {
                      isLoading = null;
                      if (res.error == null) {
                        error = res.success;
                      } else {
                        error = res.error;
                      }
                    });

                    if (res.error == null) {
                      await storage.write(key: 'erjwt', value: res.token);
                      Timer(const Duration(seconds: 2), () {
                        if (widget.editing) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Summary()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FarmerResources(
                                        editing: false,
                                      )));
                        }
                      });
                    }
                  },
                ),
              ],
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

Future<Message> submitData(bool type, String FarmerID, String SubCounty,
    String Ward, String Village, double Latitude, double Longitude) async {
  if (FarmerID.isEmpty ||
      Village.isEmpty ||
      SubCounty.isEmpty ||
      Ward.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required");
  }

  if (Latitude == 0.0 || Latitude == 0.0) {
    return Message(
        token: null,
        success: null,
        error: "Wrong location. Turn on device location");
  }

  try {
    var response;
    if (type) {
      response = await http.put(
        Uri.parse("${getUrl()}farmeraddress/${FarmerID}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'County': "Kirinyaga",
          'SubCounty': SubCounty,
          'Ward': Ward,
          'Village': Village,
          'Latitude': Latitude.toString(),
          'Longitude': Longitude.toString(),
        }),
      );
    } else {
      response = await http.post(
        Uri.parse("${getUrl()}farmeraddress/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'FarmerID': FarmerID,
          'County': "Kirinyaga",
          'SubCounty': SubCounty,
          'Ward': Ward,
          'Village': Village,
          'Latitude': Latitude.toString(),
          'Longitude': Longitude.toString(),
        }),
      );
    }

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
