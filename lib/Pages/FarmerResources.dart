// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerGroups.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class FarmerResources extends StatefulWidget {
  final bool editing;
  const FarmerResources({super.key, required this.editing});

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
      if (id != null) {
        setState(() {
          FarmerID = id;

        });
        editFarmerResources(id);
      }
    } catch (e) {}
  }

  editFarmerResources(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}farmerresources/$id"),
      );

      var body = json.decode(response.body);



      if (body.length > 0) {
        setState(() {
          data = body[0];
          TotalAcreage = body[0]["TotalAcreage"];
          CropAcreage = body[0]["CropAcreage"];
          LivestockAcreage = body[0]["LivestockAcreage"];
          IrrigationType = body[0]["IrrigationType"];
          FarmOwnership = body[0]["FarmOwnership"];
        });
      }

    } catch (e) {}
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
                    context, MaterialPageRoute(builder: (context) => Home()))
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextOakar(label: error),
                MyTextInput(
                    title: "Total Land Acreage",
                    lines: 1,
                    value: data == null ? "" : data["LivestockAcreage"],
                    type: TextInputType.number,
                    onSubmit: (value) {
                      setState(() {
                        TotalAcreage = value;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                    title: "Acreage under Crop Farming",
                    lines: 1,
                    value: data == null ? "" : data["TotalAcreage"],
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        CropAcreage = value;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                MyTextInput(
                    title: "Acreage under Livestock Farming",
                    lines: 1,
                    value: data == null ? "" : data["CropAcreage"],
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        LivestockAcreage = value;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
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
                  label: widget.editing ? "Update" : "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromRGBO(0, 128, 0, 1),
                        size: 100,
                      );
                    });
                    var res = await submitData(
                        widget.editing,
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
                        if (widget.editing) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Summary()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FarmerGroups()));
                        }
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

Future<Message> submitData(
    bool type,
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

  try {
    var response;
    if (type) {
      response = await http.put(
        Uri.parse("${getUrl()}farmerresources/$FarmerID"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'TotalAcreage': TotalAcreage,
          'CropAcreage': CropAcreage,
          'LivestockAcreage': LivestockAcreage,
          'IrrigationType': IrrigationType,
          'FarmOwnership': FarmOwnership
        }),
      );
    } else {
      response = await http.post(
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
    }

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
