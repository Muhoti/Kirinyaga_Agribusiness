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
import 'package:kirinyaga_agribusiness/Pages/CreateReport.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

class WorkPlan extends StatefulWidget {
  final String id;
  const WorkPlan({super.key, required this.id});

  @override
  State<WorkPlan> createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
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
    print("the workid is ${widget.id}");

    viewWork(widget.id);

    super.initState();
  }

  viewWork(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}workplan/farmerid/$id"),
      );

      var data = json.decode(response.body);
      print("the data alone is $data");

      print("the data is ${data[0]}");

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

      print("come on $workid, $title, $type");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Work Plan",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: Container(
                constraints: const BoxConstraints.tightForFinite(),
                child: SingleChildScrollView(
                  child: Form(
                      child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(84, 24, 84, 12),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const TextLarge(label: "Work Plan"),
                        TextOakar(label: error),
                        TextLarge(label: "Title: $title"),
                        Text(
                          title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Image: $image",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Description: $description",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          status,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Keywords: $keywords",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Latitude: $latitude",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "Longitude: $longitude",
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          CreateReport(id: widget.id)));
                            },
                            child: const Text("Create Report"))
                      ],
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
