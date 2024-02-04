// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SuDrawer.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Components/SubmitButton.dart';
import '../Components/Utils.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<StatefulWidget> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  Color mpurple = const Color.fromRGBO(90, 66, 92, 1);
  String date = '';
  final storage = const FlutterSecureStorage();
  bool checkedin = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var userDetails = null;
  String oldPass = "";
  String nePass = "";
  String cPass = "";
  String error = '';
  var isLoading;

  @override
  initState() {
    super.initState();
    getToken();
  }

  //Check for Login
  getToken() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    if (decoded["error"] == "Invalid token") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      print(decoded);
      setState(() {
        userDetails = decoded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Account",
        home: Scaffold(
            key: _key,
            appBar: AppBar(
              title: const Text(
                "Account",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            drawer: const Drawer(child: SuDrawer()),
            body: Stack(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account Details",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Name: ${userDetails != null ? userDetails["Name"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone: ${userDetails != null ? userDetails["Phone"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email: ${userDetails != null ? userDetails["Email"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Position: ${userDetails != null ? userDetails["Position"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Station: ${userDetails != null ? userDetails["Department"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 16, 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Role: ${userDetails != null ? userDetails["Role"] : ""}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      MyTextInput(
                        title: "Current Password",
                        value: "",
                        onSubmit: (v) {
                          setState(() {
                            oldPass = v;
                          });
                        },
                        lines: 1,
                        type: TextInputType.visiblePassword,
                      ),
                      MyTextInput(
                        title: "New Password",
                        value: "",
                        onSubmit: (v) {
                          setState(() {
                            nePass = v;
                          });
                        },
                        lines: 1,
                        type: TextInputType.visiblePassword,
                      ),
                      MyTextInput(
                        title: "Confirm Password",
                        value: "",
                        onSubmit: (v) {
                          setState(() {
                            cPass = v;
                          });
                        },
                        lines: 1,
                        type: TextInputType.visiblePassword,
                      ),
                      TextOakar(label: error),
                      SubmitButton(
                        label: "Submit",
                        onButtonPressed: () async {
                          setState(() {
                            error = "";
                            isLoading = LoadingAnimationWidget.twistingDots(
                              leftDotColor: Colors.orangeAccent,
                              rightDotColor: Colors.orange,
                              size: 100,
                            );
                          });
                          var res = await changePass(
                              oldPass, nePass, cPass, userDetails["UserID"]);
                          setState(() {
                            isLoading = null;
                            if (res.error == null) {
                              error = res.success;
                            } else {
                              error = res.error;
                            }
                          });
                          if (res.error == null) {
                            await storage.write(key: 'erjwt', value: "");
                            Timer(const Duration(seconds: 1), () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Login()));
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(child: isLoading),
            ])));
  }
}

Future<Message> changePass(
    String oldPass, String newPass, String cPass, String id) async {
  if (oldPass.length < 5 || newPass.length < 5 || cPass.length < 5) {
    return Message(
      token: null,
      success: null,
      error: "One of the Passwords is too short!",
    );
  }
  if (newPass != cPass) {
    return Message(
      token: null,
      success: null,
      error: "Passwords do not match!",
    );
  }
  if (id == "") {
    return Message(
      token: null,
      success: null,
      error: "You are not logged in!",
    );
  }

  try {
    final response = await http.put(
      Uri.parse("${getUrl()}mobile/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'NewPassword': newPass, 'Password': oldPass}),
    );
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
    print(e);
    return Message(
      token: null,
      success: null,
      error: "Server connection failed! Check your internet.",
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
