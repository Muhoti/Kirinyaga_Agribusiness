// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/FarmerDrawer.dart';
import 'package:kirinyaga_agribusiness/Components/FarmerReportBar.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  dynamic vcdata;
  var type = "farmer";
  dynamic isLoading;

  String valueChain = '';
  var storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    loadFarmerInfo();
  }

  loadFarmerInfo() async {
    isLoading = LoadingAnimationWidget.staggeredDotsWave(
      color: const Color.fromRGBO(0, 128, 0, 1),
      size: 100,
    );

    var id = await storage.read(key: "NationalID");
    farmerid = id!;
    print(id);

    try {
      final fdresponse = await http.get(
        Uri.parse("${getUrl()}farmerdetails/farmerid/$id"),
      );
      var fdbody = json.decode(fdresponse.body);
      print(fdbody);

      final faresponse = await http.get(
        Uri.parse("${getUrl()}farmeraddress/$id"),
      );
      var fabody = json.decode(faresponse.body);

      final frresponse = await http.get(
        Uri.parse("${getUrl()}farmerresources/$id"),
      );
      var frbody = json.decode(frresponse.body);

      final fgresponse = await http.get(
        Uri.parse("${getUrl()}farmergroups/farmerid/$id"),
      );
      var fgbody = json.decode(fgresponse.body);
      print("the fgbody info now is $fgbody");

      final vcresponse = await http.get(
        Uri.parse("${getUrl()}farmerdetails/valuechains/$id"),
      );
      var vcbody = json.decode(vcresponse.body);
      print("the fgbody info now is $vcbody");
      isLoading = null;

      setState(() {
        fddata = fdbody[0];
        fadata = fabody[0];
        frdata = frbody[0];
        fgdata = fgbody;
        vcdata = vcbody;
      });
    } catch (e) {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Farmer Summary",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromRGBO(0, 128, 0, 1),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(child: FarmerDrawer()),
        body: Stack(
          children: [
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 64),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: fddata != null
                        ? SingleChildScrollView(
                            child: FarmerReportBar(
                                fditem: fddata,
                                faitem: fadata,
                                fritem: frdata,
                                fgitem: fgdata,
                                vcitem: vcdata))
                        : const SizedBox(),
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: SubmitButton(
                  label: "Update Produce",
                  onButtonPressed: () async {
                    setState(() {
                      storage.write(key: "NationalID", value: farmerid);
                      storage.write(key: 'role', value: 'Farmer');
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FarmerValueChains()));
                  },
                ),
              ),
            ),
            Center(
              child: isLoading ?? const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
