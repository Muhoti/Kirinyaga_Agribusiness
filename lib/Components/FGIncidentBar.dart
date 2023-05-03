import 'package:flutter/material.dart';

class FGIncidentBar extends StatefulWidget {
  final dynamic item;

  const FGIncidentBar({
    super.key,
    required this.item,
  });

  @override
  State<FGIncidentBar> createState() => _FGIncidentBar();
}

class _FGIncidentBar extends State<FGIncidentBar> {

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Card(
            elevation: 5,
            color: Colors.white,
            clipBehavior: Clip.hardEdge,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      widget.item.item['Type'],
                      style: const TextStyle(
                          color: Colors.white, fontSize: 20),
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
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
