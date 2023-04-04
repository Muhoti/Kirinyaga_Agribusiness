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
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class FarmerAddress extends StatefulWidget {
  const FarmerAddress({super.key});

  @override
  State<FarmerAddress> createState() => _FarmerAddressState();
}

class _FarmerAddressState extends State<FarmerAddress> {
  String FarmerID = '';
  String County = '';
  String SubCounty = '';
  String Ward = '';
  String Village = '';
  String Latitude = '';
  String Longitude = '';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Address"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Colors.green,
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
                  label: "Add Farmer Address",
                ),
                Image.asset('assets/images/logo.png'),
                const Padding(padding: EdgeInsets.fromLTRB(24, 24, 24, 0)),
                TextOakar(label: error),
                MyTextInput(
                    title: "FarmerID",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        FarmerID = value;
                      });
                    }),
                MyTextInput(
                    title: "County",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        County = value;
                      });
                    }),
                MyTextInput(
                    title: "SubCounty",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        SubCounty = value;
                      });
                    }),
                MyTextInput(
                    title: "Ward",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        Ward = value;
                      });
                    }),
                MyTextInput(
                    title: "Village",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        Village = value;
                      });
                    }),
                MyTextInput(
                    title: "Latitude",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        Latitude = value;
                      });
                    }),
                MyTextInput(
                    title: "Longitude",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        Longitude = value;
                      });
                    }),
                SubmitButton(
                  label: "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.green,
                        size: 100,
                      );
                    });
                    var res = await postFarmerAddress(County, SubCounty, Ward,
                        Village, FarmerID, Latitude, Longitude);

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
                                builder: (context) => const FarmerResources()));
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

Future<Message> postFarmerAddress(String County, String SubCounty, String Ward,
    String Village, String FarmerID, String Latitude, String Longitude) async {
  if (FarmerID.isEmpty) {
    return Message(
        token: null, success: null, error: "FarmerID cannot be empty!");
  }

  if (County.isEmpty) {
    return Message(
        token: null, success: null, error: "County cannot be empty!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}farmeraddress/register"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'FarmerID': FarmerID,
      'County': County,
      'SubCounty': SubCounty,
      'Ward': Ward,
      'Village': Village,
      'Latitude': Latitude,
      'Longitude': Longitude,
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
