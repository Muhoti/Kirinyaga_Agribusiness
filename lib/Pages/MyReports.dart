// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/FOScrollController.dart';
import '../Components/FODrawer.dart';

class MyReports extends StatefulWidget {
  const MyReports({super.key});

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String total_farmers = '';
  String reached_farmers = '';
  String workplans = '';
  String active = 'Complete';
  String id = '';
  String status = 'Complete';
  String nationalId = '';
  String role = '';

  @override
  void initState() {
    getDefaultValues();
    super.initState();
  }

  Future<void> getDefaultValues() async {
    var token = await storage.read(key: "erjwt");
    var roles = await storage.read(key: 'role');
    print("reports for $roles");

    var decoded = parseJwt(token.toString());
    if (decoded["error"] == "Invalid token") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    } else {
      setState(() {
        name = decoded["Name"];
        id = decoded["UserID"];
        role = roles.toString();
      });
      print("reports details : $id $status, $role");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Reports",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FieldOfficerHome()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: FODrawer()),
       
        body: Column(
          children: <Widget>[
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: id == ""
                    ? const SizedBox()
                    : FOScrollController(
                        id: id, active: active, status: status)),
          ],
        ),
      ),
    );
  }
}
