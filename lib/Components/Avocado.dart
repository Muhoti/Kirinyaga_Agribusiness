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

class Avocado extends StatefulWidget {
  const Avocado({super.key, required String farmerID});

  @override
  State<Avocado> createState() => _AvocadoState();
}

class _AvocadoState extends State<Avocado> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Avocado';
  String avocadoQ1 = '';
  String avocadoQ2 = '';
  String avocadoQ3 = '';
  String avocadoQ4 = '';
  String avocadoQ5 = '';
  String avocadoQ6 = '';
  String avocadoQ7 = '';
  String avocadoQ8 = '';

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
                        title: "Avocado Acreage",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            avocadoQ1 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "No of Trees",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            avocadoQ2 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Total Production (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            avocadoQ3 = value;
                          });
                        }),
                    MyTextInput(
                        title: "Spoiled Avocadoes (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            avocadoQ4 = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Avocadoes for Home Use",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            avocadoQ5 = value;
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
                            avocadoQ6 = value;
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
                            avocadoQ7 = value;
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
                            avocadoQ8 = value;
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
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });
                        var res = await postAvocado(
                            farmerID,
                            valueChain,
                            avocadoQ1,
                            avocadoQ2,
                            avocadoQ3,
                            avocadoQ4,
                            avocadoQ5,
                            avocadoQ6,
                            avocadoQ7,
                            avocadoQ8);

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

postAvocado(
    String farmerID,
    String valueChain,
    String avocadoQ1,
    String avocadoQ2,
    String avocadoQ3,
    String avocadoQ4,
    String avocadoQ5,
    String avocadoQ6,
    String avocadoQ7,
    String avocadoQ8) async {
 
  if (valueChain.isEmpty ||
      avocadoQ2.isEmpty ||
      avocadoQ3.isEmpty ||
      avocadoQ4.isEmpty ||
      avocadoQ6.isEmpty ||
      avocadoQ7.isEmpty ||
      avocadoQ8.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
  }
    try {
  var response = await http.post(Uri.parse("${getUrl()}avocadoes"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'ValueChainName': valueChain,
        'AvocadoArea': avocadoQ1,
        'NumberOfTrees': avocadoQ2,
        'SpoiledAvocadoes': avocadoQ3,
        'HomeConsumption': avocadoQ4,
        'AvocadoPrice': avocadoQ5,
        'AvocadoIncome': avocadoQ6,
        'PO_Sales': avocadoQ7,
        'AvocadoBuyers': avocadoQ8,
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
