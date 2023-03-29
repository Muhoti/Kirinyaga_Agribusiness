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
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class FarmerDetails extends StatefulWidget {
  const FarmerDetails({super.key});

  @override
  State<FarmerDetails> createState() => _FarmerDetailsState();
}

class _FarmerDetailsState extends State<FarmerDetails> {
  String user = '';
  String nationalId = '';
  String name = '';
  String phoneNumber = '';
  String gender = '';
  String age = '';
  String error = '';
  String farmingType = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Details"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: ()=>Navigator.of(context).pop(), 
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
                  label: "Add Farmer Details",
                ),
               TextOakar(label: error),
                MyTextInput(
                    title: "User",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        user = value;
                      });
                    }),
                MyTextInput(
                    title: "Farmer Name",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        name = value;
                      });
                    }),
                MyTextInput(
                    title: "National ID",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        nationalId = value;
                      });
                    }),
                MyTextInput(
                    title: "Phone Number",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        phoneNumber = value;
                      });
                    }),
                MyTextInput(
                    title: "Gender",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        gender = value;
                      });
                    }),
                MyTextInput(
                    title: "Age Group",
                    value: "",
                    onSubmit: (value) {
                      setState(() {
                        age = value;
                      });
                    }),
                MyTextInput(
                    title: "Farming Type",
                    value: " ",
                    onSubmit: (value) {
                      setState(() {
                        farmingType = value;
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
                    var res = await postFarmerDetails(user, name, nationalId,
                        phoneNumber, gender, age, farmingType);
      
                    print(res);
                    print("bingo");
      
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
                                builder: (context) => const Home()));
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

Future<Message> postFarmerDetails(String user, String name, String nationalId,
    String phoneNumber, String gender, String age, String farmingType) async {
  print("mango");
  print(name);
  if (name.isEmpty) {
    return Message(token: null, success: null, error: "Name cannot be empty!");
  }

  if (phoneNumber.length != 10) {
    return Message(
      token: null,
      success: null,
      error: "Invalid phone number!",
    );
  }

  if (nationalId.length < 7) {
    return Message(
      token: null,
      success: null,
      error: "National ID is too short!",
    );
  }

  final response = await http.post(
    Uri.parse("${getUrl()}farmerdetails/create"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'User': user,
      'Name': name,
      'NationalID': nationalId,
      'Phone': phoneNumber,
      'Gender': gender,
      'AgeGroup': age,
      'FarmingType': farmingType
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
