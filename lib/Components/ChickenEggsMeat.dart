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

class ChickenEggsMeat extends StatefulWidget {
  const ChickenEggsMeat({super.key, required String farmerID});

  @override
  State<ChickenEggsMeat> createState() => _ChickenEggsMeatState();
}

class _ChickenEggsMeatState extends State<ChickenEggsMeat> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Chicken (Eggs & Meat)';
  String cemQ1 = '';
  String cemQ2 = '';
  String cemQ3 = '';
  String cemQ4 = '';
  String cemQ5 = '';
  String cemQ6 = '';
  String cemQ7 = '';
  String cemQ8 = '';
  String cemQ9 = '';
  String cemQ10 = '';
  String cemQ11 = '';
  String cemQ12 = '';
  String cemQ13 = '';
  String cemQ14 = '';

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
                        value: "Chicken (Eggs & Meat)",
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
                        title: "No. of Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ1 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "No. of Laying Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Produced",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ3 = value;
                          });
                        }),
                    MyTextInput(
                        title: "Spoiled Eggs",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ4 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Sold Eggs",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ5 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per Egg",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ6 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Income",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ7 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Birds Eaten Locally",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ8 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Died Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ9 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Birds Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ10 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Bird Price",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ11 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Income from Sale of Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ12 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Customer",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ13 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Chicken Customer",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            cemQ14 = value;
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
                        var res = await postChickenEggsMeat(
                            farmerID,
                            valueChain,
                            cemQ1,
                            cemQ2,
                            cemQ3,
                            cemQ4,
                            cemQ5,
                            cemQ6,
                            cemQ7,
                            cemQ8,
                            cemQ9,
                            cemQ10,
                            cemQ11,
                            cemQ12,
                            cemQ13,
                            cemQ14);

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

postChickenEggsMeat(
    String farmerID,
    String valueChain,
    String cemQ1,
    String cemQ2,
    String cemQ3,
    String cemQ4,
    String cemQ5,
    String cemQ6,
    String cemQ7,
    String cemQ8,
    String cemQ9,
    String cemQ10,
    String cemQ11,
    String cemQ12,
    String cemQ13,
    String cemQ14) async {
  print(
      "the cem values are: $farmerID, $valueChain, $cemQ1, $cemQ2, $cemQ3, $cemQ5");

  if (valueChain.isEmpty ||
      cemQ2.isEmpty ||
      cemQ3.isEmpty ||
      cemQ4.isEmpty ||
      cemQ6.isEmpty ||
      cemQ7.isEmpty ||
      cemQ8.isEmpty ||
      cemQ9.isEmpty ||
      cemQ9.isEmpty ||
      cemQ10.isEmpty ||
      cemQ11.isEmpty ||
      cemQ12.isEmpty ||
      cemQ13.isEmpty ||
      cemQ14.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
  }
  var response = await http.post(Uri.parse("${getUrl()}chickenmeateggs"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'ValueChainName': valueChain,
        'TotalBirds': cemQ1,
        'EggBirds': cemQ2,
        'NoEggs': cemQ3,
        'SpoiltEggs': cemQ4,
        'EggsSold': cemQ5,
        'EggPrice': cemQ6,
        'EggsIncome': cemQ7,
        'EatenBirds': cemQ8,
        'DiedBirds': cemQ9,
        'BirdsSold': cemQ10,
        'BirdPrice': cemQ11,
        'BirdsIncome': cemQ12,
        'EggsCustomers': cemQ13,
        'ChickenCustomers': cemQ14
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
