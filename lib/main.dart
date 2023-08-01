// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
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
  final storage = const FlutterSecureStorage();

  Future<void> checkLogin() async {
    var token = await storage.read(key: "erjwt");
    var decoded = parseJwt(token.toString());
    if (decoded["error"] == "Invalid token") {
      print("user sent to login");
       Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    }
  }

  Future<void> isUserLoggedIn() async {
    var type = await storage.read(key: "Type");

    print("the user type is $type");

    if (type == "Farmer") {
      // Verify Farmer is logged in
      var token = await storage.read(key: "erjwt");
      if (token != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const FarmerHome()));
      }
    } else if (type == "Staff") {
      // verify staff
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());

      switch (decoded["Role"]) {
        case "Field Officer":
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FieldOfficerHome()));
          });
          break;
        case "Supervisor":
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const SupervisorHome()));
          });
          break;
        case "Enumerator":
          Timer(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Home()));
          });
          break;

        default:
          const Home();
      }
    } else {
      const MyApp();
    }
  }

  @override
  void initState() {
    checkLogin();
    isUserLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(48, 24, 48, 12),
                  child: Image.asset('assets/images/logo.png'),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Text(
                    'Welcome to Kirinyaga Smart Agriculture',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 28, color: Color.fromRGBO(0, 128, 0, 1)),
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
