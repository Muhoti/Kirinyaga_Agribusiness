// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/TextView.dart';
import 'package:kirinyaga_agribusiness/Pages/SingleWP.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

class SupReport extends StatefulWidget {
  final String id;
  const SupReport({super.key, required this.id});

  @override
  State<SupReport> createState() => _SupReportState();
}

class _SupReportState extends State<SupReport> {
  String workid = '';
  String userid = '';
  String title = '';
  String type = '';
  String image = '';
  String description = '';
  String status = '';
  String keywords = '';
  String latitude = '';
  String longitude = '';
  String error = '';
  var isloading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
  

    SupReport(widget.id);

    super.initState();
  }

  SupReport(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}reports/$id"),
      );

      var data = json.decode(response.body);



      setState(() {
        workid = (data["ID"]);
        title = data["Title"];
        type = data["Type"];
        image = data["Image"];
        description = data["Description"];
        status = data["Status"];
        keywords = data["Keywords"];
        latitude = data["Latitude"];
        longitude = data["Longitude"];
      });


    } catch (e) {
    
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: "Supervisor Report",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(child: Text("SUPERVISOR REPORT")),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const FieldOfficerHome()))},
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextLarge(label: "Supervisor Report"),
                TextView(
                  label: "Title: $title",
                ),
                TextView(
                  label: "Info: $description",
                ),
                TextView(
                  label: "Image: $image",
                ),
                TextView(
                  label: "Status: $status",
                ),
                TextView(
                  label: "Keywords: $keywords",
                ),
                TextView(
                  label: "Latitude: $latitude",
                ),
                TextView(
                  label: "Longitude: $longitude",
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )),
                  child: const Text("Close"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FieldOfficerHome()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
