// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/Utils.dart';

class FarmerDetails extends StatefulWidget {
  const FarmerDetails(
      // nationalId,
      {super.key});

  @override
  State<FarmerDetails> createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  String user = '';
  String nationalId = '';
  String name = '';
  String phoneNumber = '';
  String Gender = '';
  String? selectedGender = "Male";
  String? age = '18-35 Years';
  String error = '';
  String? farmingType = 'Crop Farming';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    getNationalID(nationalId);
    if (nationalId != '') {
      editFarmerDetails(nationalId);
    }
    super.initState();
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
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTextInput(
                      title: "Name",
                      lines: 1,
                      value: "",
                      type: TextInputType.text,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          name = value;
                        });
                      },
                    ),
                    MyTextInput(
                        title: "National ID",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            error = "";
                            nationalId = value;
                          });
                        }),
                    MyTextInput(
                        title: "Phone Number",
                        lines: 1,
                        value: "",
                        type: TextInputType.phone,
                        onSubmit: (value) {
                          setState(() {
                            error = "";
                            phoneNumber = value;
                          });
                        }),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 128, 0, 1))),
                          labelText: 'Select Gender',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                        ),
                        value: selectedGender, // use selectedGender variable
                        onChanged: (newValue) {
                          setState(() {
                            error = "";
                            selectedGender = newValue;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            child: Text("Male"),
                            value: "Male",
                          ),
                          DropdownMenuItem(
                            child: Text("Female"),
                            value: "Female",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 128, 0, 1))),
                          labelText: 'Select Age Group',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                        ),
                        value: age, // use selectedGender variable
                        onChanged: (value) {
                          setState(() {
                            error = "";
                            age = value;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            child: Text("18-35 Years"),
                            value: "18-35 Years",
                          ),
                          DropdownMenuItem(
                            child: Text("36-65 Years"),
                            value: "36-65 Years",
                          ),
                          DropdownMenuItem(
                            child: Text("66 and above"),
                            value: "66 and above",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 48,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 128, 0, 1))),
                          labelText: 'Select Farming Type',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                        ),
                        value: farmingType, // use selectedGender variable
                        onChanged: (value) {
                          setState(() {
                            error = "";
                            farmingType = value;
                          });
                        },
                        items: const [
                          DropdownMenuItem(
                            child: Text("Crop Farming"),
                            value: "Crop Farming",
                          ),
                          DropdownMenuItem(
                            child: Text("Livestock Farming"),
                            value: "Livestock Farming",
                          ),
                        ],
                      ),
                    ),
                    TextOakar(label: error),
                    SubmitButton(
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          error = "";
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });
                        var res = await postFarmerDetails(
                            user,
                            name,
                            nationalId,
                            phoneNumber,
                            selectedGender!,
                            age!,
                            farmingType!);

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
                          await storage.write(key: 'erjwt', value: res.token);
                          Timer(const Duration(seconds: 2), () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FarmerAddress()));
                          });
                        }
                      },
                    ),
                  ],
                ),
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

Future<void> editFarmerDetails(String nationalId) async {
  try {
    final response = await get(
      Uri.parse("${getUrl()}farmerdetails/farmerid/$nationalId"),
    );

    var data = json.decode(response.body);
    print("Farmer Details data is $data");
  } catch (e) {}
}

void getNationalID(String nationalId) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nationalId = prefs.getString("NationalID") ?? '';
    print("the national id is $nationalId");
  } catch (e) {
    print("the national id is empty: $nationalId");
  }
}

// Update Form
void updateFarmerDetails() {}

Future<Message> postFarmerDetails(
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
    final response = await http.post(
      Uri.parse("${getUrl()}farmerdetails/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
