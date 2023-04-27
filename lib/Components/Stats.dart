import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  final String label;
  final Color color;
  final String value;
  final IconData icon;

  const Stats({
    super.key,
    required this.label,
    required this.color,
    required this.value,
    required this.icon,
  });

  @override
  State<StatefulWidget> createState() => _StatState();
}

class _StatState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: widget.color,
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Column(children: <Widget>[
              Icon(
                widget.icon,
                size: 30,
                color: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.value,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                widget.label,
                textAlign: TextAlign.left,
                textWidthBasis: TextWidthBasis.parent,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ));
  }
}
