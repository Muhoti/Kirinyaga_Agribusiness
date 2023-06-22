import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyCalendar.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Tomato extends StatefulWidget {
  const Tomato({super.key});

  @override
  State<Tomato> createState() => _TomatoState();
}

class _TomatoState extends State<Tomato> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Tomato';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String tomatoQ1 = '';
  String tomatoQ2 = '';
  String tomatoQ3 = '';
  String tomatoQ4 = '';
  String tomatoQ5 = '';
  String tomatoQ6 = '';
  String tomatoQ7 = '';
  String tomatoQ8 = '';
  String tomatoQ9 = '';
  String tomatoQ10 = '';
  String tomatoQ11 = '';
  String tomatoQ12 = '';
  String tomatoQ13 = '';
  String tomatoQ14 = '';

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
        print(farmerID);
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
                        title: "Total Land Size",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            landsize = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCalendar(
                      label: "Start Period",
                      onSubmit: (value) {
                        setState(() {
                          startPeriod = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCalendar(
                      label: "End Period",
                      onSubmit: (value) {
                        setState(() {
                          endPeriod = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Type of Farming",
                        onSubmit: (selectedFarmingType) {
                          setState(() {
                            tomatoQ1 = selectedFarmingType;
                          });
                        },
                        entries: const ["Open Field", "Green House"],
                        value: tomatoQ1),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Open Field Acreage",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Green Houses",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ3 = value;
                          });
                        }),
                    MyTextInput(
                        title: "Green House Size",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ4 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Irrigation Method",
                        onSubmit: (selectedIrrigationMethod) {
                          setState(() {
                            tomatoQ5 = selectedIrrigationMethod;
                          });
                        },
                        entries: const ["None", "Drip", "Flood", "Sprinkle"],
                        value: tomatoQ4!),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Varieties",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ6 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Inputs Cost",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ7 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount Produced (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ8 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Spoiled Tomatoes (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ9 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Tomatoes Consumed Locally (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ10 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ11 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per KG",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ12 = value;
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
                            tomatoQ13 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Target Customer / P.O",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            tomatoQ14 = value;
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
                        var res = await postTomato(
                            farmerID,
                            valueChain,
                             landsize,
                            startPeriod,
                            endPeriod,
                            tomatoQ1,
                            tomatoQ2,
                            tomatoQ3,
                            tomatoQ4,
                            tomatoQ5,
                            tomatoQ6,
                            tomatoQ7,
                            tomatoQ8,
                            tomatoQ9,
                            tomatoQ10,
                            tomatoQ11,
                            tomatoQ12,
                            tomatoQ13,
                            tomatoQ14);

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

postTomato(
    String farmerID,
    String valueChain,
    String landsize,
    String startPeriod,
    String endPeriod,
    String tomatoQ1,
    String tomatoQ2,
    String tomatoQ3,
    String tomatoQ4,
    String tomatoQ5,
    String tomatoQ6,
    String tomatoQ7,
    String tomatoQ8,
    String tomatoQ9,
    String tomatoQ10,
    String tomatoQ11,
    String tomatoQ12,
    String tomatoQ13,
    String tomatoQ14) 
    async {
  if (valueChain.isEmpty ||
      tomatoQ2.isEmpty ||
      tomatoQ3.isEmpty ||
      tomatoQ4.isEmpty ||
      tomatoQ6.isEmpty ||
      tomatoQ7.isEmpty ||
      tomatoQ8.isEmpty ||
      tomatoQ9.isEmpty ||
      tomatoQ9.isEmpty ||
      tomatoQ10.isEmpty ||
      tomatoQ11.isEmpty ||
      tomatoQ12.isEmpty ||
      tomatoQ13.isEmpty ||
      tomatoQ14.isEmpty) {
     return Message(
        token: null, success: null, error: "All fields are required!");
  }
   try {
  var response = await http.post(Uri.parse("${getUrl()}tomatoes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'ValueChainName': valueChain,
        'LandSize': landsize,
          'PeriodStart': startPeriod,
          'PeriodEnd': endPeriod,
        'GrowingMethod': tomatoQ1,
        'OpenField': tomatoQ2,
        'NoOfGreenhouses': tomatoQ3,
        'GreenhouseSize': tomatoQ4,
        'IrrigationType': tomatoQ5,
        'Variety': tomatoQ6,
        'InputCost': tomatoQ7,
        'ProductionVolume': tomatoQ8,
        'SpoiledTomatoes': tomatoQ9,
        'HomeConsumption': tomatoQ10,
        'TomatoesSold': tomatoQ11,
        'TomatoPrice': tomatoQ12,
        'TomatoIncome': tomatoQ13,
        'SalesChannel': tomatoQ14
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
