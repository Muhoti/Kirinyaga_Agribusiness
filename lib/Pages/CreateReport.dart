// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

class CreateReport extends StatefulWidget {
  final String id;
  const CreateReport({super.key, required this.id});

  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
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
                              var res = await sendReport(title, type, image,
                                  description, keywords, latitude, longitude);
                                  
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

sendReport(String title, String type, String image, String description,
    String keywords, String latitude, String longitude) async {
  if (title.isEmpty ||
      type.isEmpty ||
      image.isEmpty ||
      description.isEmpty ||
      keywords.isEmpty ||
      latitude.isEmpty ||
      longitude.isEmpty) {
    return ("All fields must be field!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}reports/create"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'Title': title, 'Type': type, 'Image': image, 'Description': description, 'Keywords': keywords, 'Latitude': latitude, 'Longitude': longitude}),
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

