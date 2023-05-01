import 'package:flutter/material.dart';

class MySelectInput extends StatefulWidget {
  final String title;
   final String value;
  final List<String> entries;
  final Function(dynamic) onSubmit;

  const MySelectInput(
      {super.key,
      required this.title,
      required this.onSubmit,
      required this.entries, required this.value});

  @override
  State<StatefulWidget> createState() => _MySelectInputState();
}

class _MySelectInputState extends State<MySelectInput> {
  List<DropdownMenuItem<String>> menuItems = [];

  @override
  void initState() {
    setState(() {
      menuItems = widget.entries
          .map((item) => DropdownMenuItem(child: Text(item), value: item))
          .toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: DropdownButtonFormField(
          items: menuItems,
          value: widget.value,
          onChanged: widget.onSubmit,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
              label: Text(
                widget.title.toString(),
                style: const TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto),
        ));
  }
}
