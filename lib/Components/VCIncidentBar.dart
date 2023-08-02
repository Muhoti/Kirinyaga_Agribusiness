import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/AddValueChain.dart';
import 'package:kirinyaga_agribusiness/Pages/ValueChainProduce.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class VCIncidentBar extends StatefulWidget {
  final dynamic item;
  final String id;
  final String vcid;
  final String valuechain;

  const VCIncidentBar(
      {super.key, required this.item, required this.id, required this.vcid, required this.valuechain});

  @override
  State<VCIncidentBar> createState() => _VCIncidentBarState();
}

class _VCIncidentBarState extends State<VCIncidentBar> {
  var dt = '';

  @override
  Widget build(BuildContext context) {
    String dateString = widget.item.item['updatedAt'];
    DateTime date = DateTime.parse(dateString);
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();

    dt = "$year-$month-$day";

    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddValueChain(
                              editing: true
                              )
                              ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.item.item['ValueChainName'],
                      style: const TextStyle(
                          color: Colors.green, fontSize: 24),
                    ),
                  ),
                ))));
  }
}
