// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/Produce.dart';
import '../Components/NavigationDrawer2.dart';
import 'package:http/http.dart' as http;
import '../Components/SubmitButton.dart';
import '../Components/Utils.dart';

class FarmerHome extends StatefulWidget {
  const FarmerHome({super.key});

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  String name = '';

  String valueChain = '';
  var storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    Future<void> pickFarmerDetails() async {
      var token = await storage.read(key: "erjwt");
      var decoded = parseJwt(token.toString());
      var id = decoded["ID"];

      setState(() {
        name = decoded["Name"].toString();
      });
      

      final response = await http.get(Uri.parse("${getUrl()}farmerdetails/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      try {
        var data = json.decode(response.body);
        print("the data is $data");
        setState(() {
          valueChain = data["FarmingType"];
        });
      } catch (e) {
        // todo
      }
    }

    pickFarmerDetails();

    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
          backgroundColor: Colors.green,
        ),
        drawer: const Drawer(child: NavigationDrawer2()),
        body: Column(
          children: <Widget>[
            Column(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Text(
                      "Welcome",
                      style: TextStyle(fontSize: 28, color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                    child: Text(
                      name,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 0),
                      child: Text(
                        valueChain,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Flexible(
                  child: Text(
                "Summary of Production",
                style: TextStyle(fontSize: 28, color: Colors.green),
              )),
              
            ),
            // const Flexible(
            //   flex: 1,
            //   fit: FlexFit.tight,
            //   child: InfiniteScrollPaginatorDemo(
            //     id: "id",
            //     status: "status",
            //     active: "active",
            //   )),
            SubmitButton(
              label: "Update Produce",
              onButtonPressed: () async {
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Produce()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
