// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Avocado.dart';
import 'package:kirinyaga_agribusiness/Components/ChickenEggsMeat.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Tomato.dart';
import 'package:kirinyaga_agribusiness/Components/TomatoSeedling.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class AddValueChain extends StatefulWidget {
  const AddValueChain({super.key, required id});

  @override
  State<AddValueChain> createState() => _AddValueChainState();
}

class _AddValueChainState extends State<AddValueChain> {
  String valueChainID = '';
  String? valueChain = 'Banana';
  String farmerID = '';
  String farmerName = '';
  String AvgHarvestProduction = '';
  String AvgYearlyProduction = '';
  String approxAcreage = '';
  String? productionUnit = 'Kilograms';
  String variety = '';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    checkMapping();
    super.initState();
  }

  checkMapping() async {
    try {
      var id = await storage.read(key: "NationalID");
      if (id != null) {
        setState(() {
          farmerID = id;
        });
      }
    } catch (e) {}
  }

  Widget getValueChainWidget(String valueChain) {
    switch (valueChain) {
      case 'Tomato':
        return Tomato(farmerID: farmerID);
      case 'Avocado':
        return Avocado(farmerID: farmerID);
      case 'Tomato Seedlings':
        return TomatoSeedling(farmerID: farmerID);
         case 'Chicken (Eggs & Meat)':
        return ChickenEggsMeat(farmerID: farmerID);
      // Add other value chain cases here
      default:
        return const SizedBox(height: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Value Chain"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Home()))
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: Stack(
        children: [
          Form(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  MySelectInput(
                      title: "Select Value Chain",
                      onSubmit: (selectedValueChain) {
                        setState(() {
                          valueChain = selectedValueChain;
                        });
                      },
                      entries: const [
                        'Tomato',
                        'Banana',
                        'Avocado',
                        'Tomato Seedlings',
                        'Chicken (Eggs & Meat)',
                        'Chicken (Egg Incubation)',
                        'Dairy',
                        'Dairy Goat',
                        'Apiculture',
                        'Pigs',
                        'Fish'
                      ],
                      value: valueChain!),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(child: getValueChainWidget(valueChain!)),
                ],
              ),
            ),
          ),
          Center(
            child: isLoading,
          )
        ],
      ),
    );
  }
}
