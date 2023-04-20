// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/NavigationDrawer2.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class FarmerResources extends StatefulWidget {
  const FarmerResources({super.key});

  @override
  State<FarmerResources> createState() => _FarmerResourcesState();
}

class _FarmerResourcesState extends State<FarmerResources> {
  String FarmerID = '';
  String TotalAcreage = '';
  String CropAcreage = '';
  String LivestockAcreage = '';
  String? IrrigationType = 'None';
  String? FarmOwnership = 'Owned';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Resources"),
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
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const TextLarge(
                //   label: "Add Farmer Resources",
                // ),
                TextOakar(label: error),
                MyTextInput(
                    title: "FarmerID",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        FarmerID = value;
                      });
                    }),
                MyTextInput(
                    title: "Total Land Acreage",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        TotalAcreage = value;
                      });
                    }),
                MyTextInput(
                    title: "Acreage under Crop Farming",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        CropAcreage = value;
                      });
                    }),
                MyTextInput(
                    title: "Acreage under Livestock Farming",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        LivestockAcreage = value;
                      });
                    }),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                      labelText: 'Type of Irrigation',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                    ),
                    value: IrrigationType,
                    onChanged: (selectedIrrigationType) {
                      setState(() {
                        IrrigationType = selectedIrrigationType;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("None"),
                        value: "None",
                      ),
                      DropdownMenuItem(
                        child: Text("Flood"),
                        value: "Flood",
                      ),
                      DropdownMenuItem(
                        child: Text("Drip"),
                        value: "Drip",
                      ),
                      DropdownMenuItem(
                        child: Text("Overhead"),
                        value: "Overhead",
                      ),
                      DropdownMenuItem(
                        child: Text("Sprinkler"),
                        value: "Sprinkler",
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
                          borderSide:
                              BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                      labelText: 'Farm Ownership',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                    ),
                    value: FarmOwnership,
                    onChanged: (selectedOwnership) {
                      setState(() {
                        FarmOwnership = selectedOwnership;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        child: Text("Owned"),
                        value: "Owned",
                      ),
                      DropdownMenuItem(
                        child: Text("Rented"),
                        value: "Rented",
                      ),
                    ],
                  ),
                ),

                SubmitButton(
                  label: "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromRGBO(0, 128, 0, 1),
                        size: 100,
                      );
                    });
                    var res = await postFarmerResources(
                        FarmerID,
                        TotalAcreage,
                        CropAcreage,
                        LivestockAcreage,
                        IrrigationType!,
                        FarmOwnership!);

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
                                builder: (context) =>
                                    const FarmerValueChains()));
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Message> postFarmerResources(
    String FarmerID,
    String TotalAcreage,
    String LivestockAcreage,
    String IrrigationType,
    String FarmOwnership,
    String CropAcreage) async {
  // if (FarmerID.isEmpty) {
  //   return Message(
  //       token: null, success: null, error: "FarmerID cannot be empty!");
  // }
  if (TotalAcreage.isEmpty) {
    return Message(
        token: null,
        success: null,
        error: "Total Land Acreage cannot be empty!");
  }
  if (FarmOwnership.isEmpty) {
    return Message(
        token: null, success: null, error: "Farm Ownership cannot be empty!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}farmerresources/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FarmerID': FarmerID,
      'TotalAcreage': TotalAcreage,
      'CropAcreage': CropAcreage,
      'LivestockAcreage': LivestockAcreage,
      'IrrigationType': IrrigationType,
      'FarmOwnership': FarmOwnership
    }),
  );
  print('This is the response $response');
  var myresponse = response.statusCode;
  print('The response $myresponse');
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
