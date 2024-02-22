import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyCalendar.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Avocado extends StatefulWidget {
  final bool editing;

  const Avocado({super.key, required String farmerID, required this.editing});

  @override
  State<Avocado> createState() => _AvocadoState();
}

class _AvocadoState extends State<Avocado> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Avocado';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String avocadoacreage = '';
  String nooftrees = '';
  String totalProduce = '';
  String spoiledavocadoes = '';
  String homeuse = '';
  String priceperkg = '';
  String totalincome = '';
  String customerpo = '';

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
                        title: "Avocado Acreage",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            avocadoacreage = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "No of Trees",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            nooftrees = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Production (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            totalProduce = value;
                          });
                        }),
                    MyTextInput(
                        title: "Spoiled Avocadoes (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            spoiledavocadoes = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Avocadoes for Home Use",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            homeuse = value;
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
                            priceperkg = value;
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
                            totalincome = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Customer / P.O",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            customerpo = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
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
                            avocadoacreage,
                            nooftrees,
                            totalProduce,
                            spoiledavocadoes,
                            homeuse,
                            priceperkg,
                            totalincome,
                            customerpo);

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
    String avocadoacreage,
    String nooftrees,
    String totalProduce,
    String spoiledavocadoes,
    String homeuse,
    String priceperkg,
    String totalincome,
    String customerpo) async {
  if (valueChain.isEmpty ||
      nooftrees.isEmpty ||
      totalProduce.isEmpty ||
      spoiledavocadoes.isEmpty ||
      priceperkg.isEmpty ||
      totalincome.isEmpty ||
      customerpo.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
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
            'AvocadoArea': avocadoacreage,
            'NumberOfTrees': nooftrees,
            'SpoiledAvocadoes': totalProduce,
            'HomeConsumption': spoiledavocadoes,
            'AvocadoPrice': homeuse,
            'AvocadoIncome': priceperkg,
            'PO_Sales': totalincome,
            'AvocadoBuyers': customerpo,
          }));
    } else {
      print("typing is $type");
      response = await http.post(Uri.parse("${getUrl()}avocadoes"),
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
            'AvocadoArea': avocadoacreage,
            'NumberOfTrees': nooftrees,
            'SpoiledAvocadoes': totalProduce,
            'HomeConsumption': spoiledavocadoes,
            'AvocadoPrice': homeuse,
            'AvocadoIncome': priceperkg,
            'PO_Sales': totalincome,
            'AvocadoBuyers': customerpo,
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
