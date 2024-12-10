// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  final String title;
  final String value;
  final int lines;
  final TextInputType type;
  final Function(String) onSubmit;

  const MyTextInput(
      {super.key,
      required this.title,
      required this.lines,
      required this.value,
      required this.type,
      required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  TextEditingController _controller = new TextEditingController();
  String _value = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != "null") {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          hintColor: Colors.greenAccent,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)))),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
          child: TextField(
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
                widget.onSubmit(value);
              },
              keyboardType: widget.type,
              controller: _controller,
              maxLines: widget.lines,
              style: const TextStyle(color: Colors.green),
              cursorColor: Colors.orange,
              obscureText: widget.type == TextInputType.visiblePassword
                  ? _obscureText
                  : false,
              enableSuggestions: true,
              autocorrect: false,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 0.0),
                  ),
                  focusColor: Colors.orange,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0)),
                  filled: false,
                  label: Text(
                    widget.title.toString(),
                    style: const TextStyle(color: Colors.green),
                  ),
                  suffixIcon: widget.type == TextInputType.visiblePassword
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )
                      : null,
                  floatingLabelBehavior: FloatingLabelBehavior.auto))),
    );
  }
}
