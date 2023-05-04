import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final onButtonPressed;

  const SubmitButton(
      {super.key, required this.label, required this.onButtonPressed});

  @override
  State<StatefulWidget> createState() => _SubmitButton();
}

class _SubmitButton extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12)
            // minimumSize: const Size.fromHeight(50), // NEW
            ),
        onPressed: widget.onButtonPressed,
        child: Text(
          widget.label,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
