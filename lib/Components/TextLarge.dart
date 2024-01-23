import 'package:flutter/material.dart';

class TextLarge extends StatefulWidget {
  final String label;
  const TextLarge({super.key, required this.label});

  @override
  State<StatefulWidget> createState() => _TextLargeState();
}

class _TextLargeState extends State<TextLarge> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Text(widget.label,
          style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 128, 0, 1))),
    );
  }
}
