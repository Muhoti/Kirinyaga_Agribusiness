// ignore_for_file: prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Model/SearchItem.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

import '../Components/Map.dart';

class CreateReport extends StatefulWidget {
  final String id;
  final String type;
  const CreateReport({super.key, required this.id, required this.type});

  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  String FarmerID = '';
  String FarmerName = '';
  String Tally = '';
  String Remarks = '';
  double Latitude = 0.0;
  double Longitude = 0.0;
  String location = '';
  String error = '';
  String check = '';
  List<SearchItem> entries = <SearchItem>[];
  var isLoading;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  final storage = const FlutterSecureStorage();
  late StreamSubscription<Position> positionStream;
  bool servicestatus = false;

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

  searchFarmer(v) async {
    setState(() {
      entries.clear();
    });
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}workplan/searchfarmer/$v"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var data = json.decode(response.body);

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(SearchItem(item["Name"], item["NationalID"]));
        }
      });
    } catch (e) {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Create Report",
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FarmerDetails()));
          },
          elevation: 5.0,
          fillColor: Colors.orange,
          padding: const EdgeInsets.all(10),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_location,
            size: 32,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: const Text("Field Officer Report"),
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 6),
                    child: SizedBox(
                        height: 250,
                        child: MyMap(
                          lat: Latitude,
                          lon: Longitude,
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 6),
                      child: Text(location)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Color.fromARGB(255, 29, 221, 163)
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Farmer: " +
                              FarmerName +
                              "\n" +
                              "National ID: " +
                              FarmerID,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  TextOakar(label: error),
                  if (widget.type == "Extension Services")
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                      child: Column(
                        children: [
                          TextFormField(
                              onChanged: (value) {
                                if (value.characters.length >=
                                    check.characters.length) {
                                  searchFarmer(value);
                                } else {
                                  setState(() {
                                    entries.clear();
                                    Tally = '';
                                    FarmerID = '';
                                    FarmerName = '';
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
                                  contentPadding:
                                      EdgeInsets.fromLTRB(24, 8, 24, 0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(0, 128, 0, 1))),
                                  filled: false,
                                  label: Text(
                                    "Search Farmer by National ID",
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 128, 0, 1)),
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always)),
                          entries.isNotEmpty
                              ? Card(
                                  elevation: 12,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(4),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: entries.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TextButton(
                                        onPressed: () {
                                          setState(() {
                                            FarmerID =
                                                entries[index].NationalID;
                                            FarmerName = entries[index].Name;
                                            Tally = '1';
                                            entries.clear();
                                          });
                                        },
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                'Name: ${entries[index].Name}, ID: ${entries[index].NationalID}')),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    )
                  else
                    MyTextInput(
                      title: 'Farmers Reached',
                      lines: 1,
                      value: '',
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          Tally = value;
                          error = '';
                        });
                      },
                    ),
                  MyTextInput(
                    title: 'Remarks',
                    lines: 8,
                    value: '',
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        Remarks = value;
                        error = '';
                      });
                    },
                  ),
                  SubmitButton(
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          error = '';
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: const Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });

                        var res = await sendReport(widget.id, Tally, Remarks,
                            Latitude, Longitude, FarmerID);

                        setState(() {
                          isLoading = null;
                          if (res.error == null) {
                            error = res.success;
                          } else {
                            error = res.error;
                          }
                        });

                        if (res.error == null) {
                          Timer(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => WorkPlan(
                                          id: widget.id,
                                        )));
                          });
                        }
                      }),
                ],
              ),
            ),
            Center(child: isLoading),
          ],
        ),
      ),
    );
  }
}

Future<Message> sendReport(String id, String Tally, String Remarks,
    double Latitude, double Longitude, String FarmerID) async {
  if (Tally == '' ||
      FarmerID == '' ||
      Remarks == '' ||
      Latitude == 0.0 ||
      Latitude == 0.0) {
    return Message(
        token: null, success: null, error: "Please fill all fields!");
  }

  try {
    final response = await http.put(
      Uri.parse("${getUrl()}workplan/${id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'Status': true,
        'FarmerID': FarmerID,
        'Tally': Tally,
        'Remarks': Remarks,
        'Longitude': Longitude,
        'Latitude': Latitude
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
