// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FMItem.dart';
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
  var data = null;
  int total = 0;
  String name = "";

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
      });
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
            context, MaterialPageRoute(builder: (_) => Summary()));
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
      setState(() {
        data = body;
        total = [
          int.parse(body["FD"]),
          int.parse(body["FA"]),
          int.parse(body["FR"]),
          int.parse(body["FG"]),
          int.parse(body["VC"])
        ].reduce(min);
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
        appBar: AppBar(
          title: const Text("Farmer Mapping Home"),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const FarmerDetails()));
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
        drawer: const Drawer(child: FMDrawer()),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 48),
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: FMItem(
                    title: "Total Farmers",
                    tally: total,
                    icon: Icons.stacked_line_chart_rounded,
                    user: name,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Row(
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
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Row(
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
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: FMItem(
                    title: "Value Chains",
                    tally: data == null ? 0 : data["VC"],
                    icon: Icons.agriculture,
                    user: '',
                  ),
                ),
              ],
            ),
          ),
          Center(child: isLoading),
        ]),
      ),
    );
  }
}
