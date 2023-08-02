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

class ChickenEggsIncubation extends StatefulWidget {
  final bool editing;

  const ChickenEggsIncubation(
      {super.key, required String farmerID, required this.editing});

  @override
  State<ChickenEggsIncubation> createState() => _ChickenEggsIncubationState();
}

class _ChickenEggsIncubationState extends State<ChickenEggsIncubation> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Chicken (Egg Incubation)';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String investmentcost = '';
  String incubators = '';
  String incubatorcapacity = '';
  String eggsincubated = '';
  String eggsspoilt = '';
  String chickshatched = '';
  String chicksdied = '';
  String chickssold = '';
  String chickscost = '';
  String income = '';

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
                    MyTextInput(
                        title: "Initial Cost of Investment",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            investmentcost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Incubators",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            incubators = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Incubator Capacity",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            incubatorcapacity = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Eggs Incubated",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            eggsincubated = value;
                          });
                        }),
                    MyTextInput(
                        title: "Number of Eggs Spoilt",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            eggsspoilt = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Chicks Hatched",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            chickshatched = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Died Chicks",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            chicksdied = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Chicks Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            chickssold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per Chick",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            chickscost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Income",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            income = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    TextOakar(label: error),
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
                            farmerID,
                            valueChain,
                            landsize,
                            startPeriod,
                            endPeriod,
                            investmentcost,
                            incubators,
                            incubatorcapacity,
                            eggsincubated,
                            eggsspoilt,
                            chickshatched,
                            chicksdied,
                            chickssold,
                            chickscost,
                            income);
                        print("the data has been submitted");
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
    String investmentcost,
    String incubators,
    String incubatorcapacity,
    String eggsincubated,
    String eggsspoilt,
    String chickshatched,
    String chicksdied,
    String chickssold,
    String chickscost,
    String income) async {
  print(
      "the cei values are: $farmerID, $valueChain, $investmentcost, $incubators, $incubatorcapacity, $eggsspoilt");

  if (valueChain.isEmpty ||
      incubators.isEmpty ||
      incubatorcapacity.isEmpty ||
      eggsincubated.isEmpty ||
      chickshatched.isEmpty ||
      chicksdied.isEmpty ||
      chickssold.isEmpty ||
      chickscost.isEmpty ||
      chickscost.isEmpty ||
      income.isEmpty) {
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
            'InitialInvestment': investmentcost,
            'Incubators': incubators,
            'IncubatorCapacity': incubatorcapacity,
            'EggsIncubated': eggsincubated,
            'SpoiltEggs': eggsspoilt,
            'ChicksHatched': chickshatched,
            'DiedChicks': chicksdied,
            'ChicksSold': chickssold,
            'ChickCost': chickscost,
            'TotaLIncome': income
          }));
    } else {
      response = await http.post(Uri.parse("${getUrl()}chickeneggsincubation"),
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
            'InitialInvestment': investmentcost,
            'Incubators': incubators,
            'IncubatorCapacity': incubatorcapacity,
            'EggsIncubated': eggsincubated,
            'SpoiltEggs': eggsspoilt,
            'ChicksHatched': chickshatched,
            'DiedChicks': chicksdied,
            'ChicksSold': chickssold,
            'ChickCost': chickscost,
            'TotaLIncome': income
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
