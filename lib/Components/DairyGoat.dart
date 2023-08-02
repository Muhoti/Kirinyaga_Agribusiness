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

class DairyGoat extends StatefulWidget {
  final bool editing;

  const DairyGoat({super.key, required this.editing});

  @override
  State<DairyGoat> createState() => _DairyGoatState();
}

class _DairyGoatState extends State<DairyGoat> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Dairy Goat';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String goats = '';
  String milkedgoats = '';
  String totalmilk = '';
  String homemilk = '';
  String milkcost = '';
  String milksold = '';
  String kidssold = '';
  String kidprice = '';
  String kidsincome = '';
  String kids = '';

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
                        title: "Number of goats",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            goats = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of goats in Production",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            milkedgoats = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Milk Produced",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            totalmilk = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Milk in Litres Consumed Locally",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            homemilk = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Milk Price per Litre",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            milkcost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Milk Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            milksold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of kids",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            kids = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of kids Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            kidssold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Average Price per Kid",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            kidprice = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Income From kids",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            kidsincome = value;
                          });
                        }),
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
                          goats,
                          milkedgoats,
                          totalmilk,
                          homemilk,
                          milkcost,
                          milksold,
                          kids,
                          kidssold,
                          kidprice,
                          kidsincome,
                        );

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
  String goats,
  String milkedgoats,
  String totalmilk,
  String homemilk,
  String milkcost,
  String milksold,
  String kids,
  String kidssold,
  String kidprice,
  String kidsincome,
) async {
  if (valueChain.isEmpty ||
      milkedgoats.isEmpty ||
      totalmilk.isEmpty ||
      homemilk.isEmpty ||
      milksold.isEmpty ||
      kidssold.isEmpty ||
      kidprice.isEmpty ||
      kids.isEmpty ||
      kidsincome.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;

    if (type) {
      response = await http.post(Uri.parse("${getUrl()}dairygoats"),
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
            'Goats': goats,
            'MilkedGoats': milkedgoats,
            'TotalMilk': totalmilk,
            'HomeMilk': homemilk,
            'MilkCost': milkcost,
            'MilkSold': milksold,
            'Kids': kids,
            'KidsSold': kidssold,
            'KidPrice': kidprice,
            'KidsIncome': kidsincome,
          }));
    } else {
      response = await http.post(Uri.parse("${getUrl()}dairygoats"),
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
            'Goats': goats,
            'MilkedGoats': milkedgoats,
            'TotalMilk': totalmilk,
            'HomeMilk': homemilk,
            'MilkCost': milkcost,
            'MilkSold': milksold,
            'Kids': kids,
            'KidsSold': kidssold,
            'KidPrice': kidprice,
            'KidsIncome': kidsincome,
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
