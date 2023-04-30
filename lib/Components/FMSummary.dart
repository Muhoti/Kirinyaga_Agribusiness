import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/ReviewMap.dart';

class FMSummary extends StatefulWidget {
  final String title;
  final bool mapped;
  final IconData icon;
  final Widget page;

  const FMSummary(
      {super.key,
      required this.title,
      r,
      required this.mapped,
      required this.icon, required this.page});

  @override
  State<FMSummary> createState() => _FMSummary();
}

class _FMSummary extends State<FMSummary> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: Colors.lightGreen,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => widget.page));
        },
        child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: 32,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                if (widget.mapped)
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 32,
                    color: Colors.green,
                  )
                else
                  const Icon(
                    Icons.close_outlined,
                    size: 32,
                    color: Colors.red,
                  ),
              ],
            )),
      ),
    );
  }
}
