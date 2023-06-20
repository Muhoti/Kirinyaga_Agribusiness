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
import 'package:kirinyaga_agribusiness/Pages/FarmerGroups.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Components/Utils.dart';

class FarmerResources extends StatefulWidget {
  final bool editing;
  const FarmerResources({super.key, required this.editing});

  @override
  State<FarmerResources> createState() => _FarmerResourcesState();
}

class _FarmerResourcesState extends State<FarmerResources> {
  String farmerID = '';
  String totalAcreage = '';
  String cropAcreage = '';
  String livestockAcreage = '';
  String irrigationType = 'None';
  String farmOwnership = 'Owned';
  String error = '';
  var data = null;
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    checkMapping();
    super.initState();
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      print("the farmer resources id is $id");
      if (id != null) {
        editFarmerResources(id);
      }
    } catch (e) {}
  }

  editFarmerResources(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}farmerresources/$id"),
      );

      var body = await json.decode(response.body);
      print("the resources body is $body");

      if (body.length > 0) {
        setState(() {
          farmerID = id;
          data = body[0];
          totalAcreage = body[0]["TotalAcreage"];
          cropAcreage = body[0]["CropAcreage"].toString();
          livestockAcreage = body[0]["LivestockAcreage"].toString();
          irrigationType = body[0]["IrrigationType"];
          farmOwnership = body[0]["FarmOwnership"];
        });
      }

      print("the resources body is $body");
    } catch (e) {}
    print(
        "resources data is $totalAcreage, $cropAcreage, $livestockAcreage, $irrigationType, $farmOwnership");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Resources"),
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
                    title: "Total Land Acreage",
                    lines: 1,
                    value: totalAcreage,
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        error = "";
                        totalAcreage = value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                      title: "Acreage Under Crop Farming",
                      lines: 1,
                      value: cropAcreage,
                      type: TextInputType.number,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          cropAcreage = value;
                        });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                      title: "Acreage under Livestock Farming",
                      lines: 1,
                      value: livestockAcreage,
                      type: TextInputType.phone,
                      onSubmit: (value) {
                        setState(() {
                          error = "";
                          livestockAcreage = value;
                        });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                    title: "Irrigation Type",
                    onSubmit: (newValue) {
                      setState(() {
                        error = "";
                        irrigationType = newValue;
                      });
                    },
                    entries: const ["None", "Flood", "Drip"],
                    value:
                        data == null ? irrigationType : data["IrrigationType"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MySelectInput(
                    title: "Farm Ownership",
                    onSubmit: (value) {
                      setState(() {
                        error = "";
                        farmOwnership = value;
                      });
                    },
                    entries: const ["Owned", "Rented"],
                    value: data == null ? farmOwnership : data["FarmOwnership"],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                      var res = await submitData(
                          widget.editing,
                          farmerID,
                          totalAcreage,
                          cropAcreage,
                          livestockAcreage,
                          irrigationType,
                          farmOwnership);

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
                                    builder: (context) => const FarmerGroups(
                                          
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
    String farmerID,
    String totalAcreage,
    String cropAcreage,
    String livestockAcreage,
    String irrigationType,
    String farmOwnership) async {
  if (totalAcreage.isEmpty) {
    return Message(
        token: null, success: null, error: "Total Acreage cannot be empty!");
  }

  try {
    var response;
    print(
        "put data is $farmerID, $totalAcreage, $cropAcreage, $livestockAcreage, $irrigationType, $farmOwnership");
    if (type) {
      response = await http.put(
        Uri.parse("${getUrl()}farmerresources/$farmerID"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'TotalAcreage': totalAcreage,
          'CropAcreage': cropAcreage,
          'LivestockAcreage': livestockAcreage,
          'IrrigationType': irrigationType,
          'FarmOwnership': farmOwnership
        }),
      );
    } else {
      response = await http.post(
        Uri.parse("${getUrl()}farmerresources"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'FarmerID': farmerID,
          'TotalAcreage': totalAcreage,
          'CropAcreage': cropAcreage,
          'LivestockAcreage': livestockAcreage,
          'IrrigationType': irrigationType,
          'FarmOwnership': farmOwnership
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
