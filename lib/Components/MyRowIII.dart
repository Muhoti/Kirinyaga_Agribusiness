import 'package:flutter/material.dart';

class MyRowIII extends StatefulWidget {
  final String no;
  final String title;
  final String image;

  const MyRowIII({
    Key? key,
    required this.no,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  State<MyRowIII> createState() => _MyRowIIIState();
}

class _MyRowIIIState extends State<MyRowIII> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 0,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                widget.image,
                width: 84,
                height: 84,
                color: Colors.orange,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                widget.no,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
