import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/ViewReport.dart';
import 'package:kirinyaga_agribusiness/Pages/WorkPlan.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class FOIncidentBar extends StatefulWidget {
  final dynamic item;

  const FOIncidentBar({
    super.key,
    required this.item,
  });

  @override
  State<FOIncidentBar> createState() => _FOIncidentBar();
}

class _FOIncidentBar extends State<FOIncidentBar> {
  String my = '';

  @override
  Widget build(BuildContext context) {
    String date = widget.item.item['Date'];

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => WorkPlan(
                                id: widget.item.item['ID'],
                              )));
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
                              child: Text(widget.item.item['Task'],
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
                                widget.item.item['Type'] + " - " + widget.item.item['SubCounty'] + " - " + widget.item.item['Ward'],
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
