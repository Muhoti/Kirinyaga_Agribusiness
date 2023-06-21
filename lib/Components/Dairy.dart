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

class Dairy extends StatefulWidget {
  const Dairy({super.key, required String farmerID});

  @override
  State<Dairy> createState() => _DairyState();
}

class _DairyState extends State<Dairy> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Dairy';
  String dairyQ1 = '';
  String dairyQ2 = '';
  String dairyQ3 = '';
  String dairyQ4 = '';
  String dairyQ5 = '';
  String dairyQ6 = '';
  String dairyQ7 = '';
  String dairyQ8 = '';
  String dairyQ9 = '';
  String dairyQ10 = '';

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
                        title: "Value Chain",
                        lines: 1,
                        value: "Dairy",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            valueChain = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Cows",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ1 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Cows in Production",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Milk Produced",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ3 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Milk in Litres Consumed Locally",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ4 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Milk Price per Litre",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ5 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Milk Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ6 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Calves",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ7 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Calves Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ8 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Average Price per Calf",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ9 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Income From Calves",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            dairyQ10 = value;
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
                        var res = await postDairy(
                            farmerID,
                            valueChain,
                            dairyQ1,
                            dairyQ2,
                            dairyQ3,
                            dairyQ4,
                            dairyQ5,
                            dairyQ6,
                            dairyQ7,
                            dairyQ8,
                            dairyQ9,
                            dairyQ10);

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

postDairy(
    String farmerID,
    String valueChain,
    String dairyQ1,
    String dairyQ2,
    String dairyQ3,
    String dairyQ4,
    String dairyQ5,
    String dairyQ6,
    String dairyQ7,
    String dairyQ8,
    String dairyQ9,
    String dairyQ10) async {
  print(
      "the Dairy values are: $farmerID, $valueChain, $dairyQ1, $dairyQ2, $dairyQ3, $dairyQ5");

  if (valueChain.isEmpty ||
      dairyQ2.isEmpty ||
      dairyQ3.isEmpty ||
      dairyQ4.isEmpty ||
      dairyQ6.isEmpty ||
      dairyQ7.isEmpty ||
      dairyQ8.isEmpty ||
      dairyQ9.isEmpty ||
      dairyQ9.isEmpty ||
      dairyQ10.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
  }
  var response = await http.post(Uri.parse("${getUrl()}dairy"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'ValueChainName': valueChain,
        'Cows': dairyQ1,
        'MilkedCows': dairyQ2,
        'TotalMilk': dairyQ3,
        'HomeMilk': dairyQ4,
        'MilkPrice': dairyQ5,
        'TotalMilkSold': dairyQ6,
        'Calves': dairyQ6,
        'CalvesSold': dairyQ7,
        'CalfPrice': dairyQ8,
        'CalfIncome': dairyQ9,
        'HomeConsumption': dairyQ10
      }));
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
