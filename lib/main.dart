// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
 

  checkLogin() {
    Future.delayed(const Duration(seconds: 2), () {
                storage.write(key: "login_option", value: "0");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    });
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(48, 24, 48, 24),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  const SizedBox(height: 100,),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Text(
                      'KiriAMIS \n Mobile App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 44, color: Color.fromRGBO(0, 128, 0, 1), fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
