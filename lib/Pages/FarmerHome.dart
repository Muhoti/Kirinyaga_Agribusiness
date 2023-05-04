// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FarmerReportBar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import '../Components/FODrawer.dart';
import 'package:http/http.dart' as http;
import '../Components/SubmitButton.dart';
import '../Components/Utils.dart';

class FarmerHome extends StatefulWidget {
  const FarmerHome({super.key});

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  String name = '';
  String farmerid = '';
  dynamic data;

  String valueChain = '';
  var storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    Future<void> pickFarmerDetails() async {
      var token = await storage.read(key: "erjwt");

      try {
        var decoded = parseJwt(token.toString());
        var id = decoded["ID"];

       
        final response = await http.get(
            Uri.parse("${getUrl()}farmerdetails/$id"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8'
            });

        var body = json.decode(response.body);

        setState(() {
          data = body;
          print("the farmer data is $data");
          farmerid = data["NationalID"];
        });
      } catch (e) {
        // todo
      }
    }

    pickFarmerDetails();

    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: FODrawer()),
        body: Stack(
          children: [
            // const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: data != null
                        ? SingleChildScrollView(
                            child: FarmerReportBar(item: data))
                        : const SizedBox(),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
