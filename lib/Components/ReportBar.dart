import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/ViewReport.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class ReportBar extends StatefulWidget {
  final dynamic item;

  const ReportBar({
    super.key,
    required this.item,
  });

  @override
  State<ReportBar> createState() => _ReportBar();
}

class _ReportBar extends State<ReportBar> {
  String my = '';

  @override
  Widget build(BuildContext context) {


    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [

              ],
            )));
  }
}
