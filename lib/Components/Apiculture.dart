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

class Apiculture extends StatefulWidget {
  final bool editing;
  const Apiculture({super.key, required this.editing});

  @override
  State<Apiculture> createState() => _ApicultureState();
}

class _ApicultureState extends State<Apiculture> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Apiculture';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String hivetype = '';
  String nohives = '';
  String hivescolonized = '';
  String harvestedquery = 'Yes';
  String crudehoney = '';
  String refinedhoney = '';
  String honeycost = '';
  String totalincome = '';
  String otherhiveproducts = '';
  String honeysold = '';
  String otherhiveincome = '';

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
                    MyTextInput(
                        title: "Type of Hive",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            hivetype = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Hives",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            nohives = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Hives Colonized",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            hivescolonized = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title:
                            "Have you harvested during the reporting period?",
                        onSubmit: (harvested) {
                          setState(() {
                            harvestedquery = harvested;
                          });
                        },
                        entries: const ["Yes", "No"],
                        value: harvestedquery),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount of Crude Honey",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            crudehoney = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount of Refined Honey",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            refinedhoney = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount sold (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            honeysold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price per KG",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            honeycost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Income from Sale of Honey",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            totalincome = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Any other Hive Products",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            otherhiveproducts = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Income from Other Hive Products",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            otherhiveincome = value;
                          });
                        }),
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
                            hivetype,
                            nohives,
                            hivescolonized,
                            harvestedquery,
                            crudehoney,
                            refinedhoney,
                            honeysold,
                            honeycost,
                            totalincome,
                            otherhiveproducts,
                            otherhiveincome);

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
  String hivetype,
  String nohives,
  String hivescolonized,
  String harvestedquery,
  String crudehoney,
  String refinedhoney,
  String honeysold,
  String honeycost,
  String totalincome,
  String otherhiveproducts,
  String otherhiveincome,
) async {
  if (valueChain.isEmpty ||
      nohives.isEmpty ||
      hivescolonized.isEmpty ||
      harvestedquery.isEmpty ||
      refinedhoney.isEmpty ||
      honeycost.isEmpty ||
      totalincome.isEmpty ||
      honeysold.isEmpty ||
      otherhiveproducts.isEmpty ||
      otherhiveincome.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;

    if (type) {
      print("typing is $type");
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
            'HiveType': hivetype,
            'NoHives': nohives,
            'HivesColonized': hivescolonized,
            'HarvestedQuery': harvestedquery,
            'CrudeHoney': crudehoney,
            'RefinedHoney': refinedhoney,
            'HoneySold': honeysold,
            'HoneyCost': honeycost,
            'TotalIncome': totalincome,
            'OtherHiveProducts': otherhiveproducts,
            'OtherHiveIncome': otherhiveincome
          }));
    } else {
      print("typing is $type");
      response = await http.post(Uri.parse("${getUrl()}apiculture"),
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
            'HiveType': hivetype,
            'NoHives': nohives,
            'HivesColonized': hivescolonized,
            'HarvestedQuery': harvestedquery,
            'CrudeHoney': crudehoney,
            'RefinedHoney': refinedhoney,
            'HoneySold': honeysold,
            'HoneyCost': honeycost,
            'TotalIncome': totalincome,
            'OtherHiveProducts': otherhiveproducts,
            'OtherHiveIncome': otherhiveincome
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
