import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/CreateFarmerGroup.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/Map.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';

class FarmerGroups extends StatefulWidget {
  const FarmerGroups({super.key});

  @override
  State<FarmerGroups> createState() => _FarmerGroupsState();
}

class _FarmerGroupsState extends State<FarmerGroups> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farmer Associations"),
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                ),
                SubmitButton(
                  label: "Add Farmer Group",
                  onButtonPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateFarmerGroup();
                      },
                    );
                  },
                ),
                SubmitButton(
                  label: "Proceed",
                  onButtonPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const FarmerValueChains()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
