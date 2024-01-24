import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/NavigationButton.dart';
import 'package:kirinyaga_agribusiness/Components/ReportBar.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/TextView.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateReport.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WorkPlan extends StatefulWidget {
  final String id;

  const WorkPlan({Key? key, required this.id}) : super(key: key);

  @override
  _WorkPlanState createState() => _WorkPlanState();
}

class _WorkPlanState extends State<WorkPlan> {
  late Widget loadingWidget;
  dynamic data;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    loadingWidget = LoadingAnimationWidget.staggeredDotsWave(
      color: Color.fromRGBO(0, 128, 0, 1),
      size: 100,
    );
    viewWork(widget.id);
  }

  Future<void> viewWork(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}workplan/$id"),
      );

      var body = json.decode(response.body);

      setState(() {
        data = body;
        loadingWidget = SizedBox.shrink();
      });
    } catch (e) {
      setState(() {
        loadingWidget = SizedBox.shrink();
      });
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: PreferredSize(
        child: const Text("View Task"),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      actions: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => FieldOfficerHome()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ],
      backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
    );
  }

  Widget _buildReportContainer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 24, 12, 30),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.green,
          width: 2.0, // Adjust the width of the border as needed
        ),
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.transparent
          ], // Use transparent colors
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.credit_card,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  (data?["Task"] ?? ""),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  softWrap: true,
                  maxLines: null,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                "Due:" + data?["Date"] ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_indent_increase,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  (data?["Description"] ?? ""),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                  softWrap: true,
                  maxLines: null,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.pin_drop,
                size: 18,
                color: Colors.green,
              ),
              const SizedBox(width: 8),
              Text(
                data != null ? "${data["SubCounty"]}, ${data["Ward"]}" : "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: data != null
          ? SingleChildScrollView(
              child: !data["Status"]
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        _buildReportContainer(),
                        const SizedBox(height: 24),
                        SubmitButton(
                          label: "Submit Report",
                          onButtonPressed: () {
                            if (data != null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CreateReport(
                                    id: data["ID"],
                                    type: data["Description"],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  : ReportBar(item: data),
            )
          : const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Work Plan",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            _buildContent(),
            Center(child: loadingWidget),
          ],
        ),
      ),
    );
  }
}
