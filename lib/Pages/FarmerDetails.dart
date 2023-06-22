// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:kirinyaga_agribusiness/Pages/ValueChainForm.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/Utils.dart';

class FarmerDetails extends StatefulWidget {
  final bool editing;
  const FarmerDetails({super.key, required this.editing});

  @override
  State<FarmerDetails> createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  String user = '';
  String nationalId = '';
  String name = '';
  String phoneNumber = '';
  String gender = "Male";
  String age = '18-35 Years';
  String error = '';
  String farmingType = 'Crop Farming';
  var isLoading;
  var data = null;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    getToken();
    checkMapping();
    super.initState();
  }

  getToken() async {
    try {
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());
  
      setState(() {
        user = decoded["Name"];
      });
    } catch (e) {

    }
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      if (id != null) {
        editFarmerDetails(id);
      }
    } catch (e) {}
  }

  editFarmerDetails(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}farmerdetails/farmerid/$id"),
      );

      var body = await json.decode(response.body);

      if (body.length > 0) {
        setState(() {
          data = body[0];
          name = body[0]["Name"];
          nationalId = body[0]["NationalID"];
          phoneNumber = body[0]["Phone"];
          gender = body[0]["Gender"];
          age = body[0]["AgeGroup"];
          farmingType = body[0]["FarmingType"];
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Details"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()))
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
                  MyTextInput(
                    title: "Name",
                    lines: 1,
                    value: data == null ? "" : data["Name"],
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        error = "";
                        name = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                      title: "National ID",
                      lines: 1,
                      value: data == null ? "" : data["NationalID"],
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          nationalId = value;
                        });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                      title: "Phone Number",
                      lines: 1,
                      value: data == null ? "" : data["Phone"],
                      type: TextInputType.phone,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          phoneNumber = value;
                        });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                    title: "Gender",
                    onSubmit: (newValue) {
                      setState(() {
                        error = "";
                        gender = newValue;
                      });
                    },
                    entries: const ["Male", "Female"],
                    value: data == null ? "Male" : data["Gender"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                    title: "Age Group",
                    onSubmit: (value) {
                      setState(() {
                        error = "";
                        age = value;
                      });
                    },
                    entries: const [
                      "18-35 Years",
                      "36-65 Years",
                      "66 and Above"
                    ],
                    value: data == null ? "18-35 Years" : data["AgeGroup"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                      title: "Farming Type",
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          age = value;
                        });
                      },
                      entries: const [
                        "Crop Farming",
                        "Livestock Farming",
                        "Mixed Farming",
                      ],
                      value:
                          data == null ? "Crop Farming" : data["FarmingType"]),
                  TextOakar(label: error),
                  SubmitButton(
                    label: widget.editing ? "Update" : "Submit",
                    onButtonPressed: () async {
                      setState(() {
                        error = "";
                        isLoading = LoadingAnimationWidget.staggeredDotsWave(
                          color: const Color.fromRGBO(0, 128, 0, 1),
                          size: 100,
                        );
                      });
                      var res = await submitData(widget.editing, user, name,
                          nationalId, phoneNumber, gender, age, farmingType);

                      setState(() {
                        isLoading = null;
                        if (res.error == null) {
                          error = res.success;
                          storage.write(key: "NationalID", value: nationalId);
                        } else {
                          error = res.error;
                        }
                      });

                      if (res.error == null) {
                      
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
                                    builder: (context) => const FarmerAddress(
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
    bool type,
    String user,
    String name,
    String nationalId,
    String phoneNumber,
    String selectedGender,
    String age,
    String farmingType) async {
  if (name.isEmpty) {
    return Message(token: null, success: null, error: "Name cannot be empty!");
  }

  if (phoneNumber.length < 10) {
    return Message(
      token: null,
      success: null,
      error: "Invalid phone number!",
    );
  }

  if (nationalId.length < 7) {
    return Message(
      token: null,
      success: null,
      error: "National ID is too short!",
    );
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;
    if (type) {
      response = await http.put(
        Uri.parse("${getUrl()}farmerdetails/${nationalId}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, String>{
          'User': user,
          'Name': name,
          'Phone': phoneNumber,
          'Gender': selectedGender,
          'AgeGroup': age,
          'FarmingType': farmingType
        }),
      );
    } else {
      response = await http.post(
        Uri.parse("${getUrl()}farmerdetails/create"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token!
        },
        body: jsonEncode(<String, String>{
          'User': user,
          'Name': name,
          'NationalID': nationalId,
          'Phone': phoneNumber,
          'Gender': selectedGender,
          'AgeGroup': age,
          'FarmingType': farmingType
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
