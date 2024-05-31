// ignore_for_file: prefer_typing_uninitialized_variables, file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:kirinyaga_agribusiness/Components/ReportBar.dart';
import 'package:kirinyaga_agribusiness/Pages/MyWorkPlans.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorModule.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import '../Components/SuReportBar.dart';

class SupWorkPlan extends StatefulWidget {
  final String id;
  final String name;
  const SupWorkPlan({super.key, required this.id, required this.name});

  @override
  State<SupWorkPlan> createState() => _SupWorkPlanState();
}

class _SupWorkPlanState extends State<SupWorkPlan> {
  var isloading;
  bool reviewed = false;
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
        Uri.parse("${getUrl()}workplan/supervisor/$id"),
      );

      var body = json.decode(response.body);

      setState(() {
        data = body;
        isloading = null;
        reviewed = body["SupervisorRemarks"] == null ? false : true;
      });

      print('supervisor review: $reviewed');
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
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "${widget.name} Report",
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {Navigator.pop(context)},
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
                    child: reviewed
                        ? ReportBar(item: data)
                        : SuReportBar(
                            item: data,
                          ))
                : const SizedBox(),
          ),
          Center(child: isloading),
        ]),
      ),
    );
  }
}
