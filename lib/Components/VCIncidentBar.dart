import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/ValueChainProduce.dart';
// import 'package:kirinyaga_agribusiness/Pages/Incident.dart';

class VCIncidentBar extends StatefulWidget {
  final dynamic item;
  final String id;

  const VCIncidentBar({
    super.key,
    required this.item,
    required this.id
  });

  @override
  State<VCIncidentBar> createState() => _VCIncidentBarState();
}

class _VCIncidentBarState extends State<VCIncidentBar> {
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ValueChainProduce(
                                id: widget.item.item['ID'],
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.blue,
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
                              child: Text(widget.item.item['Name'],
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
                                widget.item.item['Name'],
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
