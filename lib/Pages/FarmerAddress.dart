// ignore_for_file: prefer_typing_uninitialized_variables, unused_field, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/NavigationDrawer2.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/counties.dart';

import '../Components/Utils.dart';

class FarmerAddress extends StatefulWidget {
  const FarmerAddress({super.key});

  @override
  State<FarmerAddress> createState() => _FarmerAddressState();
}

class _FarmerAddressState extends State<FarmerAddress> {
  String FarmerID = '';
  String County = '';
  String SubCounty = '';
  String Ward = '';
  String Village = '';
  String Latitude = '';
  String Longitude = '';
  String error = '';
  String location = '';
  bool servicestatus = false;
  var isLoading;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  double long = 0.0, lat = 0.0;
  late StreamSubscription<Position> positionStream;
  final storage = const FlutterSecureStorage();

  late String _selectedSubCounty = kirinyagaSubCounties.first;
  String? _selectedWard;

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
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
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
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
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 1, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
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
    // Cancel the timer to prevent calling setState after the widget has been disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("the subcuunty is $SubCounty and ward is $Ward");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Address"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: NavigationDrawer2()),
      body: SingleChildScrollView(
        //child: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const TextLarge(
              //   label: "Add Farmer Address",
              // ),
              SizedBox(
                  height: 250,
                  child: MyMap(
                    lat: lat,
                    lon: long,
                  )),
              Text(location),
              // const SizedBox(
              //   height: 10,
              // ),
              //const Padding(padding: EdgeInsets.fromLTRB(24, 24, 24, 0)),
              TextOakar(label: error),
              MyTextInput(
                  title: "FarmerID",
                  value: "",
                  onSubmit: (value) {
                    setState(() {
                      FarmerID = value;
                    });
                  }),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //       color: Colors.grey,
              //       width: 1.0,
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: DropdownButton(
              //       value: SubCounty,
              //       items: kirinyagaSubCounties.map((option) {
              //         return DropdownMenuItem(
              //           value: option,
              //           child: Text(option),
              //         );
              //       }).toList(),
              //       onChanged: (value) {
              //         setState(() {
              //           SubCounty = value!;
              //         });
              //       },
              //       icon: Icon(Icons.arrow_drop_down),
              //       iconSize: 24,
              //       elevation: 16,
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 16,
              //       ),
              //       underline: Container(),
              //       ),
              // ),



              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                    labelText: 'Sub County',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                  ),

                  value: SubCounty,
                  // onChanged: (value) {
                  //   setState(() {
                  //     _selectedSubCounty = value!;
                  //   });
                  // },
                  items: kirinyagaSubCounties.map((SubCounty) {
                    return DropdownMenuItem(
                      value: SubCounty,
                      child: Text(SubCounty),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubCounty = value!;
                      _selectedWard = null;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: MediaQuery.of(context).size.width - 48,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                    labelText: 'Ward',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                  ),
                  value: Ward,
                  // onChanged: (value) {
                  //   setState(() {
                  //     _selectedSubCounty = value!;
                  //   });
                  // },
                  onChanged: (value) {
                    setState(() {
                      _selectedWard = value as String?;
                    });
                  },
                  items: _selectedSubCounty != null
                      ? kirinyagaWards[_selectedSubCounty as String]!
                          .map((Ward) => DropdownMenuItem(
                                value: Ward,
                                child: Text(Ward),
                              ))
                          .toList()
                      : [],
                ),
              ),

              MyTextInput(
                  title: "County",
                  value: "",
                  onSubmit: (value) {
                    setState(() {
                      County = value;
                    });
                  }),

              MyTextInput(
                  title: "Village",
                  value: "",
                  onSubmit: (value) {
                    setState(() {
                      Village = value;
                    });
                  }),
              MyTextInput(
                  title: "Latitude",
                  value: "",
                  onSubmit: (value) {
                    setState(() {
                      Latitude = lat.toString();
                    });
                  }),
              MyTextInput(
                  title: "Longitude",
                  value: "",
                  onSubmit: (value) {
                    setState(() {
                      Longitude = long.toString();
                    });
                  }),
              SubmitButton(
                label: "Submit",
                onButtonPressed: () async {
                  setState(() {
                    isLoading = LoadingAnimationWidget.staggeredDotsWave(
                      color: Color.fromRGBO(0, 128, 0, 1),
                      size: 100,
                    );
                  });
                  var res = await postFarmerAddress(County, SubCounty, Ward,
                      Village, FarmerID, Latitude, Longitude);

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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FarmerResources()));
                    });
                  }
                },
              ),
            ],
          ),
        ),
        //),
      ),
    );
  }
}

Future<Message> postFarmerAddress(String County, String SubCounty, String Ward,
    String Village, String FarmerID, String Latitude, String Longitude) async {
  if (FarmerID.isEmpty) {
    return Message(
        token: null, success: null, error: "FarmerID cannot be empty!");
  }

  // if (County.isEmpty) {
  //   return Message(
  //       token: null, success: null, error: "County cannot be empty!");
  // }

  final response = await http.post(
    Uri.parse("${getUrl()}farmeraddress/register"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FarmerID': FarmerID,
      'County': County,
      'SubCounty': SubCounty,
      'Ward': Ward,
      'Village': Village,
      'Latitude': Latitude,
      'Longitude': Longitude,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 203) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Message.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
