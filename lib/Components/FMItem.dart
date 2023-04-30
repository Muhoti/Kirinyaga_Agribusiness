import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/ReviewMap.dart';

class FMItem extends StatefulWidget {
  final String title;
  final int tally;
  final IconData icon;
  final String user;

  FMItem(
      {super.key,
      required this.title,
      required this.tally,
      required this.icon,
      required this.user});

  @override
  State<FMItem> createState() => _FMItem();
}

class _FMItem extends State<FMItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.lightGreen,
      child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          child: Column(
            children: [
              Icon(
                widget.icon,
                size: 44,
                color: Colors.orange,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Center(
                  child: Text(
                    widget.tally.toString(),
                    style: const TextStyle(fontSize: 34, color: Colors.white),
                  ),
                ),
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
              if (widget.user != '')
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Mapped by:  ${widget.user}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
            ],
          )),
    );
  }
}
