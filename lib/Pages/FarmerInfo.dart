// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:http/http.dart' as http;

import '../Components/TextView.dart';
import '../Components/Utils.dart';

class FarmerInfo extends StatefulWidget {
  final String id;
  const FarmerInfo({super.key, required this.id});

  @override
  State<FarmerInfo> createState() => _FarmerInfoState();
}

class _FarmerInfoState extends State<FarmerInfo> {
  String NationalID = '';
  String Name = '';
  String Phone = '';
  String Gender = '';
  String AgeGroup = '';
  String FarmingType = '';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    viewFarmerInfo(widget.id);

    super.initState();
  }

  viewFarmerInfo(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}farmerdetails/$id"),
      );
      var data = json.decode(response.body);

      setState(() {
        Name = data["Name"];
        Phone = data["Phone"];
        Gender = data["Gender"];
        AgeGroup = data["AgeGroup"];
        FarmingType = data["FarmingType"];
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Information"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => {Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const FarmerHome()))},
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextLarge(
                  label: "Farmer Profile Bio",
                ),
                TextOakar(label: error),
                TextView(
                  label: "Name: $Name",
                ),
                TextView(
                  label: "Number: $Phone",
                ),
                TextView(
                  label: "Gender: $Gender",
                ),
                TextView(
                  label: "Age: $AgeGroup",
                ),
                TextView(
                  label: "Type: $FarmingType",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
