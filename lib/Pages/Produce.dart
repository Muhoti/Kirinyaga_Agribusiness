// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/NavigationDrawer2.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class Produce extends StatefulWidget {
  const Produce({super.key});

  @override
  State<Produce> createState() => _ProduceState();
}

class _ProduceState extends State<Produce> {
  String valueChainID = '';
  String valueChain = '';
  String farmerID = '';
  String produce = '';
  String harvestDate = '';
  String farmingPeriod = '';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Produce"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: NavigationDrawer2()),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextLarge(
                  label: "Update Farm Produce",
                ),
                TextOakar(label: error),
                MyTextInput(
                    title: "ValueChain ID",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        valueChainID = value;
                      });
                    }),
                MyTextInput(
                    title: "Value Chain",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        valueChain = value;
                      });
                    }),
                MyTextInput(
                    title: "Farmer ID",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        farmerID = value;
                      });
                    }),
                MyTextInput(
                    title: "Produce",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        produce = value;
                      });
                    }),
                MyTextInput(
                    title: "Harvest Date",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        harvestDate = value;
                      });
                    }),
                MyTextInput(
                    title: "Farming Period",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        farmingPeriod = value;
                      });
                    }),
                SubmitButton(
                  label: "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromRGBO(0, 128, 0, 1),
                        size: 100,
                      );
                    });
                    var res = await postProduce(valueChainID, valueChain,
                        farmerID, produce, harvestDate, farmingPeriod);

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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FarmerHome()));
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Message> postProduce(
    String valueChainID,
    String valueChain,
    String farmerID,
    String produce,
    String harvestDate,
    String farmingPeriod) async {
  if (valueChainID.isEmpty ||
      valueChain.isEmpty ||
      farmerID.isEmpty ||
      produce.isEmpty ||
      harvestDate.isEmpty ||
      farmingPeriod.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}valuechainproduce"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'ValueChainID': valueChainID,
      'ValueChain': valueChain,
      'FarmerID': farmerID,
      'Produce': produce,
      'HarvestDate': harvestDate,
      'FarmingPeriod': farmingPeriod,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 203) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Message.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
