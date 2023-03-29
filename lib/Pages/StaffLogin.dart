// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StatefulWidget> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  String email = '';
  String password = '';
  String error = '';
  var isLoading;
  String role = '';
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Staff Login",
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(children: <Widget>[
            Center(
                child: Container(
                    constraints: const BoxConstraints.tightForFinite(),
                    child: SingleChildScrollView(
                      child: Form(
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: <Widget>[
                                                  Image.asset('assets/images/logo.png'),
                                                  const TextLarge(label: "Staff Login"),
                                                  TextOakar(label: error),
                                                  MyTextInput(
                                                    title: 'Email',
                                                    value: '',
                                                    type: TextInputType.emailAddress,
                                                    onSubmit: (value) {
                                                      setState(() {
                                                        email = value;
                                                      });
                                                    },
                                                  ),
                                                  MyTextInput(
                                                    title: 'Password',
                                                    value: '',
                                                    type: TextInputType.visiblePassword,
                                                    onSubmit: (value) {
                                                      setState(() {
                                                        password = value;
                                                      });
                                                    },
                                                  ),
                                                  SubmitButton(
                                                    label: "Login",
                                                    onButtonPressed: () async {
                                                      setState(() {
                                                        isLoading =
                                                            LoadingAnimationWidget.staggeredDotsWave(
                                                          color: Colors.green,
                                                          size: 100,
                                                        );
                                                      });
                                                      var res = await login(email, password);
                                                      setState(() {
                                                        isLoading = null;
                                                        if (res.error == null) {
                                                          error = res.success;
                                                        } else {
                                                          error = res.error;
                                                        }
                                                      });
                                                      if (res.error == null) {
                              await storage.write(
                                  key: 'erjwt', value: res.token);
                              var decoded = parseJwt(res.token.toString());
                              Timer(const Duration(seconds: 2), () {
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (_) => const Home()));
                              });
                              //checkRole(decoded["Password"], role, context);
                                                      }
                                                    },
                                                  ),
                                                  const TextOakar(
                                                      label: "Powered by \n Oakar Services Ltd.")
                                                ]))),
                    ))),
            Center(child: isLoading),
          ])),
    );
  }
}

Future<Message> login(String email, String password) async {
  if (email.isEmpty || !EmailValidator.validate(email)) {
    return Message(
      token: null,
      success: null,
      error: "Email is invalid!",
    );
  }

  if (password.length < 6) {
    return Message(
      token: null,
      success: null,
      error: "Password is too short!",
    );
  }

  final response = await http.post(
    Uri.parse("${getUrl()}mobile/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'Email': email, 'Password': password}),
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
