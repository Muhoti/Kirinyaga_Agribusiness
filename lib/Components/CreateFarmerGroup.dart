// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerGroups.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Model/SearchItem.dart';
import 'SubmitButton.dart';
import 'Utils.dart';

class CreateFarmerGroup extends StatefulWidget {
  CreateFarmerGroup({super.key});

  @override
  State<StatefulWidget> createState() => _CreateFarmerGroup();
}

class _CreateFarmerGroup extends State<CreateFarmerGroup> {
  final storage = const FlutterSecureStorage();
  List<SearchItem> entries = <SearchItem>[];
  String error = '';
  String check = '';
  String groupname = '';
  String grouptype = 'CIG';
  String farmerID = '';
  var data = null;
  var isLoading;

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
    return SimpleDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Farmer\'s Group',
          style: TextStyle(color: Colors.green),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: Column(
            children: [
              MyTextInput(
                title: "Farmer's Group Name",
                lines: 1,
                value: groupname,
                type: TextInputType.text,
                onSubmit: (value) {
                  setState(() {
                    error = "";
                    groupname = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              MySelectInput(
                title: "Farmer's Group Type",
                onSubmit: (newValue) {
                  setState(() {
                    error = "";
                    grouptype = newValue;
                  });
                },
                entries: const ["CIG", "SACCO", "P.O", "Cohort", "Other"],
                value: data == null ? "CIG" : data["Gender"],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
                ),
                onPressed: () async {
                  setState(() {
                    error = "";
                    isLoading = LoadingAnimationWidget.staggeredDotsWave(
                      color: const Color.fromRGBO(0, 128, 0, 1),
                      size: 100,
                    );
                  });

                  var res =
                      await postFarmerGroups(farmerID, groupname, grouptype);

                  setState(() {
                    isLoading = null;
                    if (res.error == null) {
                      error = res.success;
                    } else {
                      error = res.error;
                    }
                  });

                  if (res.error == null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FarmerGroups()));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
        const SizedBox()
      ],
    );
  }
}

Future<Message> postFarmerGroups(
    String farmerID, String groupname, String grouptype) async {
  if (groupname.isEmpty) {
    return Message(
        token: null, success: null, error: "Farmer Group cannot be empty!");
  }
  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "kiriamisjwt");
    var response;
    response = await http.post(
      Uri.parse("${getUrl()}farmergroups"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token!
      },
      body: jsonEncode(<String, String>{
        'FarmerID': farmerID,
        'Name': groupname,
        'Type': grouptype,
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
