import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChickenEggsIncubation extends StatefulWidget {
  const ChickenEggsIncubation({super.key, required String farmerID});

  @override
  State<ChickenEggsIncubation> createState() => _ChickenEggsIncubationState();
}

class _ChickenEggsIncubationState extends State<ChickenEggsIncubation> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Chicken (Egg Incubation)';
  String ceiQ1 = '';
  String ceiQ2 = '';
  String ceiQ3 = '';
  String ceiQ4 = '';
  String ceiQ5 = '';
  String ceiQ6 = '';
  String ceiQ7 = '';
  String ceiQ8 = '';
  String ceiQ9 = '';
  String ceiQ10 = '';

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
          farmerID = id;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    MyTextInput(
                        title: "Initial Cost of Investment",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ1 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Incubators",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Incubator Capacity",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ3 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Incubated",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ4 = value;
                          });
                        }),
                    MyTextInput(
                        title: "Number of Eggs Spoilt",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ5 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Chicks Hatched",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ6 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Died Chicks",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ7 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Chicks Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ8 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per Chick",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ9 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Income",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            ceiQ10 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextOakar(label: error),
                    SubmitButton(
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });
                        var res = await postChickenEggsIncubation(
                            farmerID,
                            valueChain,
                            ceiQ1,
                            ceiQ2,
                            ceiQ3,
                            ceiQ4,
                            ceiQ5,
                            ceiQ6,
                            ceiQ7,
                            ceiQ8,
                            ceiQ9,
                            ceiQ10);

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
                            Navigator.push(
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
          Center(
            child: isLoading,
          )
        ],
      ),
    );
  }
}

postChickenEggsIncubation(
    String farmerID,
    String valueChain,
    String ceiQ1,
    String ceiQ2,
    String ceiQ3,
    String ceiQ4,
    String ceiQ5,
    String ceiQ6,
    String ceiQ7,
    String ceiQ8,
    String ceiQ9,
    String ceiQ10) async {
  print(
      "the cei values are: $farmerID, $valueChain, $ceiQ1, $ceiQ2, $ceiQ3, $ceiQ5");

  if (valueChain.isEmpty ||
      ceiQ2.isEmpty ||
      ceiQ3.isEmpty ||
      ceiQ4.isEmpty ||
      ceiQ6.isEmpty ||
      ceiQ7.isEmpty ||
      ceiQ8.isEmpty ||
      ceiQ9.isEmpty ||
      ceiQ9.isEmpty ||
      ceiQ10.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }

  try {
  var response = await http.post(Uri.parse("${getUrl()}chickeneggsincubation"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'ValueChainName': valueChain,
        'InitialInvestment': ceiQ1,
        'Incubators': ceiQ2,
        'IncubatorCapacity': ceiQ3,
        'EggsIncubated': ceiQ4,
        'SpoiltEggs': ceiQ5,
        'ChicksHatched': ceiQ6,
        'DiedChicks': ceiQ7,
        'ChicksSold': ceiQ8,
        'ChickCost': ceiQ9,
        'TotaLIncome': ceiQ10
      }));
    var body = jsonDecode(response.body);

    if (body["success"] != null) {
      return Message(
          token: body["token"], success: body["success"], error: body["error"]);
    } else {
      return Message(
          token: body["token"], success: body["success"], error: body["error"]);
    }
  } catch (e) {
    print("error: $e");
    return Message(token: null, success: null, error: "Something went wrong!");
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
