import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String no;

  const MyImage({super.key, required this.no});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                  ),
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 155, 248, 6), // Green color
                    width: 1, // Border width
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                  ),
                  border: Border.all(
                    color:
                        const Color.fromARGB(255, 155, 248, 6), // Green color
                    width: 2, // Border width
                  ),
                ),
                child: Center(
                  child: Text(
                    no, // Replace with the desired number
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 155, 248, 6), // Green color
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
