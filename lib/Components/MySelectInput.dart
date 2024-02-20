import 'package:flutter/material.dart';

class MySelectInput extends StatefulWidget {
  final String title;
  final String value;
  final List<String> entries;
  final Function(String) onSubmit;
  const MySelectInput(
      {super.key,
      required this.entries,
      required this.title,
      required this.onSubmit,
      required this.value});

  @override
  State<StatefulWidget> createState() => _MySelectInputState();
}

class _MySelectInputState extends State<MySelectInput> {
  List<DropdownMenuItem<String>> menuItems = [];
  String _selectedOption = "";

  @override
  void initState() {
    if (widget.entries.isNotEmpty) {
      setState(() {
        if (widget.entries.contains(widget.value)) {
          _selectedOption = widget.value;
        } else {
          _selectedOption = widget.entries[0];
        }
        menuItems = widget.entries
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList();
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MySelectInput oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    if (widget.entries.isNotEmpty) {
      setState(() {
        if (widget.entries.contains(widget.value)) {
          _selectedOption = widget.value;
        } else {
          _selectedOption = widget.entries[0];
        }
        menuItems = widget.entries
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          hintColor: Colors.green,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Stack(
          children: [
            TextField(
              onChanged: (value) {},
              onTap: () {},
              enabled: false,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(color: Colors.transparent),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  hintStyle: const TextStyle(color: Colors.green),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 0.0),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 0.0),
                  ),
                  focusColor: Colors.yellow,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 1.0)),
                  filled: false,
                  label: Text(
                    widget.title,
                    style: const TextStyle(color: Colors.green),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 16, 0),
              child: DropdownButton<String>(
                icon: const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.green,
                  ),
                ),
                isExpanded: true,
                underline: Container(),
                value: _selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                  widget.onSubmit(newValue!);
                },
                items: widget.entries
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.green),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
