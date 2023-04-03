import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {
  final String label;
  final String active;
  dynamic buttonPressed;
  NavigationButton(
      {super.key,
      required this.label,
      required this.active,
      required this.buttonPressed});

  @override
  State<StatefulWidget> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  var colors = Colors.green;

  @override
  void initState() {
    super.initState();
    setState(() {
      colors = widget.active == widget.label ? Colors.green : Colors.grey;
    });
  }

  @override
  void didUpdateWidget(covariant NavigationButton oldWidget) {
    if (oldWidget.active != widget.active) {
      setState(() {
        colors = widget.active == widget.label ? Colors.green : Colors.grey;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: TextButton(
              onPressed: widget.buttonPressed,
              child: Text(
                widget.label,
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.white),
              )),
        ));
  }
}
