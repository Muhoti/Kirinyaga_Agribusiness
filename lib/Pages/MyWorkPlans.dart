// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateWorkPlan.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Scroll/FOScrollController.dart';
import '../Components/FODrawer.dart';

class MyWorkPlans extends StatefulWidget {
  const MyWorkPlans({super.key});

  @override
  State<MyWorkPlans> createState() => _MyWorkPlansState();
}

class _MyWorkPlansState extends State<MyWorkPlans> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String workplans = '';
  String active = 'Pending';
  String id = '';
  String status = 'Pending';
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
    print("workplans for $roles");

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

      print("workplan details : $id, $status, $role");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Workplans",
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
        floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateWorkPlan(userid: id)));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(13, 50, 10, 1),
          ),
          child: const Text(
            'Create Workplan',
            style: TextStyle(color: Colors.white),
          ),
        ),
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
