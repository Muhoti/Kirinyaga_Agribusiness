// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FarmerReportBar.dart';
import '../Components/FODrawer.dart';
import 'package:http/http.dart' as http;
import '../Components/Utils.dart';

class FarmerHome extends StatefulWidget {
  const FarmerHome({super.key});

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  String name = '';
  String farmerid = '';
  dynamic fddata;
  dynamic fadata;
  dynamic frdata;
  dynamic fgdata;

  String valueChain = '';
  var storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    Future<void> loadFarmerInfo() async {
      var token = await storage.read(key: "erjwt");
      var id = await storage.read(key: "NationalID");

      setState(() {
        farmerid = id!;
      });

      try {
        var decoded = parseJwt(token.toString());
        var id = decoded["ID"];

        final fdresponse = await http.get(
          Uri.parse("${getUrl()}farmerdetails/$id"),
        );

        final faresponse = await http.get(
          Uri.parse("${getUrl()}farmeraddress/$farmerid"),
        );

        final frresponse = await http.get(
          Uri.parse("${getUrl()}farmerresources/$farmerid"),
        );

        final fgresponse = await http.get(
          Uri.parse("${getUrl()}farmergroups/farmerid/$farmerid"),
        );

        var fdbody = json.decode(fdresponse.body);
        var fabody = json.decode(faresponse.body);
        var frbody = json.decode(frresponse.body);
        var fgbody = json.decode(fgresponse.body);

        setState(() {
          fddata = fdbody;
          fadata = fabody;
          frdata = frbody;
          fgdata = fgbody;

          print(
              "Farmer details info: $fddata, Farmer addresses info: $fadata, Farmer resources info: $frbody, Farmer groups info: $fgbody");
        });
      } catch (e) {
        // todo
      }
    }

    loadFarmerInfo();

    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Color.fromRGBO(0, 128, 0, 1),
        ),
        drawer: const Drawer(child: FODrawer()),
        body: Stack(
          children: [
            // const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: fddata != null
                        ? SingleChildScrollView(
                            child: FarmerReportBar(fditem: fddata, faitem: fadata, fritem: frdata, fgitem: fgdata))
                        : const SizedBox(),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
