import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
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
                  padding: const EdgeInsets.fromLTRB(16, 6, 24, 6),
                  child: Row(
                    children: [
                      Icon(
                        DateTime(
                                    int.parse(date.split("-")[0]),
                                    int.parse(date.split("-")[1]),
                                    int.parse(date.split("-")[2]))
                                .isAfter(DateTime.now())
                            ? Icons.check
                            : Icons.schedule,
                        color: DateTime(
                                    int.parse(date.split("-")[0]),
                                    int.parse(date.split("-")[1]),
                                    int.parse(date.split("-")[2]))
                                .isAfter(DateTime.now())
                            ? Colors.green
                            : Colors.orange,
                        size: 54,
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
                                widget.item.item['Type'] +
                                    " - " +
                                    widget.item.item['Date'],
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
