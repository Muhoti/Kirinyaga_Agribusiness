// import 'package:ambulex_app/Pages/Incident.dart';
// import 'package:ambulex_app/Pages/ViewCompleted.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateReport.dart';
import 'package:kirinyaga_agribusiness/Pages/ViewReport.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class IncidentBar extends StatefulWidget {
  final String title;
  final String description;
  final String status;
  final String keywords;
  final String image;
  final String lat;
  final String id;
  final String long;
  final String createdat;

  const IncidentBar({
    super.key,
    required this.title,
    required this.description,
    required this.status,
    required this.keywords,
    required this.image,
    required this.lat,
    required this.id,
    required this.long,
    required this.createdat,
  });

  @override
  State<StatefulWidget> createState() => _StatState();
}

class _StatState extends State<IncidentBar> {
  String my = '';

  @override
  Widget build(BuildContext context) {

    String date = widget.createdat;
    List<String> dateParts = date.split("-");
    String year = dateParts[0].substring(2);
    String month = dateParts[1];
     my = "$month/$year";

    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: TextButton(
                onPressed: () {
                  if (widget.status == "Pending") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => WorkPlan(
                                  id: widget.id,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ViewReport(
                                  id: widget.id,
                                )));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          my,
                          style: const TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.title,
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(42, 74, 40, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.description,
                                textAlign: TextAlign.left,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}
