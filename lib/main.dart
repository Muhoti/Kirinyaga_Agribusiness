
// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'Components/Utils.dart';
import 'Pages/Home.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    // check for login
    getToken() async {

      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());

      if (decoded["error"] == "Invalid token") {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => const Login()));

      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (_) => const Home()));
      }
    }

    Timer(const Duration(seconds: 2), () {
      getToken();
    });

    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Text(
                    'Welcome to Kirinyaga Smart Agriculture',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
