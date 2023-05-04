import 'package:flutter/material.dart';
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
    print("the incident bar is ${widget.vcid}");

    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Card(
            elevation: 5,
            color: Colors.lightGreen,
            clipBehavior: Clip.hardEdge,
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ValueChainProduce(
                              vcid: widget.vcid, farmerID: widget.id, valuechain: widget.valuechain)));
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(0, 128, 0, 1),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          widget.item.item['Name'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 28),
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
                              child: Text(
                                  "Yearly Produce is: ${widget.item.item["AvgYearlyProduction"]}",
                                  textAlign: TextAlign.left,
                                  textWidthBasis: TextWidthBasis.parent,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 243, 227, 6),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dt,
                                textAlign: TextAlign.left,
                                textWidthBasis: TextWidthBasis.parent,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 243, 227, 6),
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
