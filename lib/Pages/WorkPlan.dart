// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

class WorkPlan extends StatefulWidget {
  final String id;
  const WorkPlan({super.key, required this.id});

  @override
  State<WorkPlan> createState() => _CreateReportState();
}

class _CreateReportState extends State<WorkPlan> {
  String userid = '';
  String title = '';
  String type = '';
  String image = '';
  String description = '';
  String status = '';
  String keywords = '';
  String latitude = '';
  String longitude = '';
  String error = '';
  var isloading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    print("the widget id is ${widget.id}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Create Report",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: Container(
                constraints: const BoxConstraints.tightForFinite(),
                child: SingleChildScrollView(
                  child: Form(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(84, 24, 84, 12),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const TextLarge(label: "Create Report"),
                        TextOakar(label: error),
                        MyTextInput(
                          title: 'Title',
                          value: '',
                          type: TextInputType.emailAddress,
                          onSubmit: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Type',
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Image',
                          value: '',
                          type: TextInputType.emailAddress,
                          onSubmit: (value) {
                            setState(() {
                              image = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Description',
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Status',
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              status = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Keywords',
                          value: '',
                          type: TextInputType.emailAddress,
                          onSubmit: (value) {
                            setState(() {
                              keywords = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Latitude',
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              latitude = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Longitude',
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              longitude = value;
                            });
                          },
                        ),
                        SubmitButton(
                            label: "Submit",
                            onButtonPressed: () async {
                              setState(() {
                                isloading =
                                    LoadingAnimationWidget.staggeredDotsWave(
                                  color: const Color.fromRGBO(0, 128, 0, 1),
                                  size: 100,
                                );
                              });
                              var res = await sendReport(
                                  userid = widget.id,
                                  title,
                                  type,
                                  image,
                                  description,
                                  status,
                                  keywords,
                                  latitude,
                                  longitude);

                              print("the response is $res");

                              setState(() {
                                isloading = null;
                                if (res.error == null) {
                                  error = res.success;
                                } else {
                                  error = res.error;
                                }
                              });
                              if (res.error == null) {
                                await storage.write(
                                    key: 'erjwt', value: res.token);
                                Timer(const Duration(seconds: 2), () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const FarmerHome()));
                                });
                              }
                            }),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<Message> sendReport(
    String userid,
    String title,
    String type,
    String image,
    String description,
    String status,
    String keywords,
    String latitude,
    String longitude) async {
  if (title.isEmpty ||
      type.isEmpty ||
      image.isEmpty ||
      description.isEmpty ||
      keywords.isEmpty ||
      latitude.isEmpty ||
      longitude.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all fields!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}reports/create"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'UserID': userid,
      'Title': title,
      'Type': type,
      'Image': image,
      'Description': description,
      'Status': status,
      'Keywords': keywords,
      'Latitude': latitude,
      'Longitude': longitude
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 203) {
    //getToken(role);
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
