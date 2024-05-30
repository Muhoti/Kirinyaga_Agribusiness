// ignore_for_file: prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/ReportBar.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateReport.dart';
import 'package:kirinyaga_agribusiness/Pages/FOWorkPlanStats.dart';
import 'package:kirinyaga_agribusiness/Pages/MyReports.dart';
import 'package:kirinyaga_agribusiness/Pages/MyWorkPlans.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';

class WorkPlan extends StatefulWidget {
  final String id;
  const WorkPlan({super.key, required this.id});

  @override
  State<WorkPlan> createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
  var isloading;
  dynamic data;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    setState(() {
      isloading = LoadingAnimationWidget.staggeredDotsWave(
        color: Color.fromRGBO(0, 128, 0, 1),
        size: 100,
      );
    });
    viewWork(widget.id);

    super.initState();
  }

  viewWork(String id) async {
    try {
      final response = await get(
        Uri.parse("${getUrl()}workplan/$id"),
      );

      var body = json.decode(response.body);

      setState(() {
        data = body;
        isloading = null;
      });
    } catch (e) {
      setState(() {
        isloading = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Work Plan",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Field Officer Report",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MyReports()))
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: data != null
                ? SingleChildScrollView(
                    child: !data["Status"]
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(12, 24, 12, 30),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green,
                                      Color.fromARGB(255, 29, 221, 163)
                                    ],
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 1,
                                          child: Text(
                                            data?["Task"],
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                14, 6, 14, 6),
                                            decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            child: Text(data["Date"],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Service Type: " + data["Type"],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.pin_drop,
                                          size: 44,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          flex: 1,
                                          child: Text(
                                            data != null
                                                ? data["SubCounty"] +
                                                    ", " +
                                                    data["Ward"]
                                                : "",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SubmitButton(
                                  label: "Submit Report",
                                  onButtonPressed: () => {
                                        if (data != null)
                                          {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CreateReport(
                                                            id: data["ID"],
                                                            type:
                                                                data["Type"])))
                                          }
                                      })
                            ],
                          )
                        : ReportBar(item: data))
                : const SizedBox(),
          ),
          Center(child: isloading),
        ]),
      ),
    );
  }
}
