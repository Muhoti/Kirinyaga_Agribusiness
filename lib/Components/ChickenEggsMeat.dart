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

class ChickenEggsMeat extends StatefulWidget {
  final bool editing;

  const ChickenEggsMeat(
      {super.key, required String farmerID, required this.editing});

  @override
  State<ChickenEggsMeat> createState() => _ChickenEggsMeatState();
}

class _ChickenEggsMeatState extends State<ChickenEggsMeat> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Chicken (Eggs & Meat)';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String birds = '';
  String layingbirds = '';
  String eggs = '';
  String spoilteggs = '';
  String soldeggs = '';
  String eggprice = '';
  String eggincome = '';
  String birdseaten = '';
  String diedbirds = '';
  String birdssold = '';
  String birdsprice = '';
  String birdsincome = '';
  String eggscustomers = '';
  String chickencustomers = '';

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
                      height: 24,
                    ),
                    MyTextInput(
                        title: "No. of Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            birds = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "No. of Laying Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            layingbirds = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Produced",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            eggs = value;
                          });
                        }),
                    MyTextInput(
                        title: "Spoiled Eggs",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            spoilteggs = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Sold Eggs",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            soldeggs = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per Egg",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            eggprice = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Income",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            eggincome = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Birds Eaten Locally",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            birdseaten = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Died Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            diedbirds = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Birds Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            birdssold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Bird Price",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            birdsprice = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Income from Sale of Birds",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            birdsincome = value;
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
                            eggscustomers = value;
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
                            chickencustomers = value;
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
                        var res = await submitData(
                            widget.editing,
                            farmerID,
                            valueChain,
                            landsize,
                            startPeriod,
                            endPeriod,
                            birds,
                            layingbirds,
                            eggs,
                            spoilteggs,
                            soldeggs,
                            eggprice,
                            eggincome,
                            birdseaten,
                            diedbirds,
                            birdssold,
                            birdsprice,
                            birdsincome,
                            eggscustomers,
                            chickencustomers);

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

submitData(
    bool type,
    String farmerID,
    String valueChain,
    String landsize,
    String startPeriod,
    String endPeriod,
    String birds,
    String layingbirds,
    String eggs,
    String spoilteggs,
    String soldeggs,
    String eggprice,
    String eggincome,
    String birdseaten,
    String diedbirds,
    String birdssold,
    String birdsprice,
    String birdsincome,
    String eggscustomers,
    String chickencustomers) async {
  print(
      "the cem values are: $farmerID, $valueChain, $birds, $layingbirds, $eggs, $soldeggs");

  if (valueChain.isEmpty ||
      layingbirds.isEmpty ||
      eggs.isEmpty ||
      spoilteggs.isEmpty ||
      eggprice.isEmpty ||
      eggincome.isEmpty ||
      birdseaten.isEmpty ||
      diedbirds.isEmpty ||
      diedbirds.isEmpty ||
      birdssold.isEmpty ||
      birdsprice.isEmpty ||
      birdsincome.isEmpty ||
      eggscustomers.isEmpty ||
      chickencustomers.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }
  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;

    if (type) {
      response = await http.post(Uri.parse("${getUrl()}valuechainproduce"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token!
          },
          body: jsonEncode(<String, String>{
            'FarmerID': farmerID,
            'ValueChainName': valueChain,
            'LandSize': landsize,
            'PeriodStart': startPeriod,
            'PeriodEnd': endPeriod,
            'TotalBirds': birds,
            'EggBirds': layingbirds,
            'NoEggs': eggs,
            'SpoiltEggs': spoilteggs,
            'EggsSold': soldeggs,
            'EggPrice': eggprice,
            'EggsIncome': eggincome,
            'EatenBirds': birdseaten,
            'DiedBirds': diedbirds,
            'BirdsSold': birdssold,
            'BirdPrice': birdsprice,
            'BirdsIncome': birdsincome,
            'EggsCustomers': eggscustomers,
            'ChickenCustomers': chickencustomers
          }));
    } else {
      response = await http.post(Uri.parse("${getUrl()}chickenmeateggs"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token!
          },
          body: jsonEncode(<String, String>{
            'FarmerID': farmerID,
            'ValueChainName': valueChain,
            'LandSize': landsize,
            'PeriodStart': startPeriod,
            'PeriodEnd': endPeriod,
            'TotalBirds': birds,
            'EggBirds': layingbirds,
            'NoEggs': eggs,
            'SpoiltEggs': spoilteggs,
            'EggsSold': soldeggs,
            'EggPrice': eggprice,
            'EggsIncome': eggincome,
            'EatenBirds': birdseaten,
            'DiedBirds': diedbirds,
            'BirdsSold': birdssold,
            'BirdPrice': birdsprice,
            'BirdsIncome': birdsincome,
            'EggsCustomers': eggscustomers,
            'ChickenCustomers': chickencustomers
          }));
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
