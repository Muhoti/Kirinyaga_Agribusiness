import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class FarmerLogin extends StatefulWidget {
  const FarmerLogin({super.key});

  @override
  State<StatefulWidget> createState() => _FarmerLoginState();
}

class _FarmerLoginState extends State<FarmerLogin> {
  String phone = '';
  String nationalId = '';
  String error = '';
  dynamic isLoading;
  final storage = const FlutterSecureStorage();
  late bool _isMounted; // Add a variable to track widget mount state

  @override
  void initState() {
    super.initState();
    _isMounted = true;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Farmer Login",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: <Widget>[
            Center(
              child: Container(
                constraints: const BoxConstraints.tightForFinite(),
                child: SingleChildScrollView(
                  child: Form(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(84, 24, 84, 12),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          const TextLarge(label: "Farmer Login"),
                          TextOakar(label: error),
                          MyTextInput(
                            title: 'Phone Number',
                            lines: 1,
                            value: '',
                            type: TextInputType.phone,
                            onSubmit: (value) {
                              setState(() {
                                phone = value;
                              });
                            },
                          ),
                          MyTextInput(
                            title: 'National ID',
                            lines: 1,
                            value: '',
                            type: TextInputType.number,
                            onSubmit: (value) {
                              setState(() {
                                nationalId = value;
                              });
                            },
                          ),
                          SubmitButton(
                            label: "Login",
                            onButtonPressed: _handleLogin,
                          ),
                          const TextOakar(
                            label: "Powered by \n Oakar Services Ltd.",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(child: isLoading),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (phone.length != 10) {
      setState(() {
        error = "Invalid phone number!";
      });
      return;
    }

    if (nationalId.length < 6) {
      setState(() {
        error = "National ID is too short!";
      });
      return;
    }

    final response = await http.post(
      Uri.parse("${getUrl()}farmerdetails/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Phone': phone,
        'NationalID': nationalId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 203) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final res = Message.fromJson(jsonDecode(response.body));
      setState(() {
        if (res.error == null) {
          error = res.success;
        } else {
          error = res.error;
        }
      });
      if (res.error == null) {
        await storage.write(key: 'Type', value: 'Farmer');
        await storage.write(key: 'NationalID', value: nationalId);
        Timer(const Duration(seconds: 2), () {
          if (_isMounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FarmerHome()),
            );
          }
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      setState(() {
        error = "Connection to server failed!";
      });
    }
  }

  void _handleLogin() async {
    setState(() {
      isLoading = LoadingAnimationWidget.staggeredDotsWave(
        color: Color.fromRGBO(0, 128, 0, 1),
        size: 100,
      );
    });
    await _login();
    setState(() {
      isLoading = null;
    });
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
