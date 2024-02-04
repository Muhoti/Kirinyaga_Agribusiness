// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FMItem.dart';
import 'package:kirinyaga_agribusiness/Components/SuDrawer.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import '../Components/FMDrawer.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isLoading;
  dynamic data;
  int total = 0;
  String name = "";
  String role = "";

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    getToken();
    checkMapping();
    super.initState();
  }

  getToken() async {
    try {
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());

      setState(() {
        name = decoded["Name"];
        role = decoded["Role"];
      });
      print("the token is $decoded");
      searchMapped(decoded["Name"]);
    } catch (e) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Login()));
    }
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      if (id != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Summary()));
      }
    } catch (e) {}
  }

  searchMapped(user) async {
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}farmerdetails/mapped/$user"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var body = json.decode(response.body);
      print("the body is $body");

      List<int> numbers = [
        body["FD"],
        body["FA"],
        body["FR"],
        body["FG"],
        body["VC"]
      ];
      int minimum = numbers.reduce(
          (currentMin, element) => element < currentMin ? element : currentMin);
      print("Minimum: $minimum");

      setState(() {
        data = body;
        total = minimum;
      });
    } catch (e) {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Farmer Mapping Home"),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FarmerDetails(
                          editing: false,
                        )));
          },
          elevation: 5.0,
          fillColor: Colors.orange,
          padding: const EdgeInsets.all(10),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add_location,
            size: 24,
            color: Colors.white,
          ),
        ),
        drawer: Drawer(
            child: role == "Enumerator" ? const FMDrawer() : const SuDrawer()),
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FMItem(
                    title: "Total Farmers",
                    tally: total,
                    icon: Icons.stacked_line_chart_rounded,
                    user: name,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Info",
                          tally: data == null ? 0 : data["FD"],
                          icon: Icons.person_2_rounded,
                          user: '',
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Address",
                          tally: data == null ? 0 : data["FA"],
                          icon: Icons.location_pin,
                          user: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farm Resources",
                          tally: data == null ? 0 : data["FR"],
                          icon: Icons.library_books,
                          user: '',
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Groups",
                          tally: data == null ? 0 : data["FG"],
                          icon: Icons.groups,
                          user: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  FMItem(
                    title: "Value Chains",
                    tally: data == null ? 0 : data["VC"],
                    icon: Icons.agriculture,
                    user: '',
                  ),
                ],
              ),
            ),
          ),
          Center(child: isLoading),
        ]),
      ),
    );
  }
}
