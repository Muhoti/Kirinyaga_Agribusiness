// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FMItem.dart';
import '../Components/FODrawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Farmer Mapping Home"),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: FODrawer()),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: FMItem(
                    title: "Total Farmers",
                    tally: "1256",
                    icon: Icons.stacked_line_chart_rounded,
                    user: 'Duncan Muteti',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Info",
                          tally: "1256",
                          icon: Icons.person_2_rounded,
                          user: '',
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Address",
                          tally: "1256",
                          icon: Icons.location_pin,
                          user: '',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farm Resources",
                          tally: "1256",
                          icon: Icons.library_books,
                          user: '',
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: FMItem(
                          title: "Farmer Groups",
                          tally: "1256",
                          icon: Icons.groups,
                          user: '',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 7,
                  child: FMItem(
                    title: "Value Chains",
                    tally: "1256",
                    icon: Icons.agriculture,
                    user: '',
                  ),
                ),
              ],
            ),
          ),
          Center(child: isLoading),
        ]),
      ),
    );
  }
}
