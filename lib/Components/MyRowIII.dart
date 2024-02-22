// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyRowIII extends StatefulWidget {
  final String no;
  final String title;
  final String image;

  const MyRowIII({
    super.key,
    required this.no,
    required this.title,
    required this.image,
  });

  @override
  State<MyRowIII> createState() => _MyRowIIIState();
}

class _MyRowIIIState extends State<MyRowIII> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Plain white background
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 3, // Spread radius
            blurRadius: 5, // Blur radius
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  widget.image,
                  width: 84, // Set width of the image
                  height: 84, // Set height of the image
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
                color: Colors.black, // Adjust text color if needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
