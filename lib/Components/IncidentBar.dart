// import 'package:ambulex_app/Pages/Incident.dart';
// import 'package:ambulex_app/Pages/ViewCompleted.dart';
import 'package:flutter/material.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class IncidentBar extends StatefulWidget {
  final String type;
  final String status;
  final String name;
  final String address;
  final String landmark;
  final String city;
  final String id;
  final String customerID;

  const IncidentBar({
    super.key,
    required this.type,
    required this.status,
    required this.name,
    required this.address,
    required this.landmark,
    required this.city,
    required this.id,
    required this.customerID,
  });

  @override
  State<StatefulWidget> createState() => _StatState();
}

class _StatState extends State<IncidentBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: TextButton(
                onPressed: () {
                  // if (widget.status == "In Progress") {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => Incident(id: widget.customerID)));
                  // } else {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) =>
                  //               ViewCompleted(id: widget.customerID)));
                  // }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: widget.type == "ME"
                                ? Colors.red
                                : Colors.orange,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
                        child: Text(widget.type,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(children: <Widget>[
                            Text(
                              widget.name,
                              textAlign: TextAlign.left,
                              textWidthBasis: TextWidthBasis.parent,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${widget.city} - ${widget.address}: Near ${widget.landmark}",
                              style: const TextStyle(),
                            ),
                          ]))
                    ],
                  ),
                ))));
  }
}
