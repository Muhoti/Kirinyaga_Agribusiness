// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
import '../Components/NavigationDrawer2.dart';
import 'package:http/http.dart' as http;
import '../Components/Utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    Future<void> checkRole() async {
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());
      var id = decoded["UserID"];

      final response = await http.get(Uri.parse("${getUrl()}mobile/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      try {
        var data = json.decode(response.body);
        String role = data["Role"];
        print("the role is $role");
        switch (role) {
          case "Field Officer":
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FieldOfficerHome()));
            break;
          case "Supervisor":
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const SupervisorHome()));
            break;
          case "Enumerator":
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const FarmerDetails()));
            break;

          default:
            const Home();
        }
      } catch (e) {
        // TO-DO
      }
    }

    checkRole();

    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: Colors.green,
        ),
        drawer: const Drawer(child: NavigationDrawer2()),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Text(
                  'Home Page',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, color: Colors.green),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
