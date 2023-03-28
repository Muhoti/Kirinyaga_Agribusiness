import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final String label;
  final onButtonPressed;

  const SubmitButton({super.key, required this.label, required this.onButtonPressed});

  @override
  State<StatefulWidget> createState() => _SubmitButton();
}

class _SubmitButton extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(54, 12, 54, 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size.fromHeight(50), // NEW
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
