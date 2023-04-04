// import 'package:ambulex_app/Pages/Incident.dart';
// import 'package:ambulex_app/Pages/ViewCompleted.dart';
import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class IncidentBar extends StatefulWidget {
  final String title;
  final String status;
  final String description;
  final String keywords;
  final String image;
  final String lat;
  final String id;
  final String long;

  const IncidentBar({
    super.key,
    required this.title,
    required this.status,
    required this.description,
    required this.keywords,
    required this.image,
    required this.lat,
    required this.id,
    required this.long,
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
                  if (widget.status == "In Progress") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Home()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                Home()));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: widget.image == "ME"
                                ? Colors.red
                                : Colors.orange,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
                        child: Text(widget.title,
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
                              widget.description,
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
                              "${widget.title} - ${widget.description}: Near ${widget.lat}",
                              style: const TextStyle(),
                            ),
                          ]))
                    ],
                  ),
                ))));
  }
}
