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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => WorkPlan(
                                id: widget.item.item['ID'],
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_box,
                            size: 50,
                            color: Colors.green,
                          ),
                          const SizedBox(
                              height:
                                  10), // Adding some space between the icon and text
                          Text(
                            "${widget.item.item['Task']}".length >= 10
                                ? "${widget.item.item['Task']}"
                                        .substring(0, 10) +
                                    "..."
                                : "${widget.item.item['Task']}" + "...",                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.view_list,
                            size: 50,
                            color: Colors.green,
                          ),
                          const SizedBox(
                              height:
                                  10), // Adding some space between the icon and text
                          Text(
                            "${widget.item.item['Description']}".length >= 5
                                ? "${widget.item.item['Description']}"
                                    .substring(0, 10) + "..."
                                : "${widget.item.item['Description']}" + "...",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.pin_drop,
                            size: 50,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 100,
                            child: Text(
                              "${widget.item.item['Location']}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))));
  }
}
