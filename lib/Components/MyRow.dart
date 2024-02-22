import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/MyImage.dart';

class MyRow extends StatefulWidget {
  final String no;
  final String title;
  const MyRow({Key? key, required this.no, required this.title})
      : super(key: key);

  @override
  State<MyRow> createState() => _MyRowState();
}

class _MyRowState extends State<MyRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFF9F1), // Cream color
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white, // White color
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            blurRadius: 6, // Spread radius
            offset: Offset(4, 4), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/myactivity.png',
                  width: 84, // Set width of the image
                  height: 84, // Set height of the image
                  color: Colors.orange,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      widget.no,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Align(
               alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward, color: Colors.green,))
          ],
        ),
      ),
    );
  }
}
