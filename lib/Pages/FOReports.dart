// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextView.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateReport.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorReport.dart';

class FOReports extends StatefulWidget {
  final String id;
  const FOReports({super.key, required this.id});

  @override
  State<FOReports> createState() => _FOReportsState();
}

class _FOReportsState extends State<FOReports> {
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
    viewWork(widget.id);

    super.initState();
  }

  viewWork(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}workplan/$id"),
      );

      var data = json.decode(response.body);

      setState(() {
        workid = (data["UserID"]);
        title = data["Title"];
        type = data["Type"];
        image = data["Image"];
        description = data["Description"];
        status = data["Status"];
        keywords = data["Keywords"];
        latitude = data["Latitude"];
        longitude = data["Longitude"];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Field Officer Report",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(child: Text("Supervisor Tasks")),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextLarge(label: "Field Officer Report"),
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
                  child: const Text("Approve"),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SupervisorReport(id: workid)));
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
