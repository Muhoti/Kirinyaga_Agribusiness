// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/Apiculture.dart';
import 'package:kirinyaga_agribusiness/Components/Avocado.dart';
import 'package:kirinyaga_agribusiness/Components/ChickenEggsIncubation.dart';
import 'package:kirinyaga_agribusiness/Components/ChickenEggsMeat.dart';
import 'package:kirinyaga_agribusiness/Components/Dairy.dart';
import 'package:kirinyaga_agribusiness/Components/DairyGoat.dart';
import 'package:kirinyaga_agribusiness/Components/Fish.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/Pigs.dart';
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
  const AddValueChain({super.key});

  @override
  State<AddValueChain> createState() => _AddValueChainState();
}

class _AddValueChainState extends State<AddValueChain> {
  String valueChainID = '';
  String? valueChain = 'Select Value Chain';
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
        return const Tomato();
      case 'Avocado':
        return Avocado(farmerID: farmerID);
      case 'Tomato Seedlings':
        return TomatoSeedling(farmerID: farmerID);
      case 'Chicken (Eggs & Meat)':
        return ChickenEggsMeat(farmerID: farmerID);
      case 'Chicken (Egg Incubation)':
        return ChickenEggsIncubation(farmerID: farmerID);
      case 'Dairy':
        return const Dairy();
      case 'Dairy Goat':
        return const DairyGoat();
      case 'Apiculture':
        return const Apiculture();
      case 'Pigs':
        return const Pigs();
      case 'Fish':
        return const Fish();
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
        backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
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
                        'Select Value Chain',
                        'Apiculture',
                        'Avocado',
                        'Chicken (Egg Incubation)',
                        'Chicken (Eggs & Meat)',
                        'Dairy',
                        'Dairy Goat',
                        'Fish',
                        'Pigs',
                        'Tomato',
                        'Tomato Seedlings'
                      ],
                      value: valueChain!),
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: getValueChainWidget(valueChain!)),
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
