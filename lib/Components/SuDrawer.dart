import 'package:kirinyaga_agribusiness/Components/SearchFarmer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerInfo.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
import 'package:kirinyaga_agribusiness/main.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../Model/SearchItem.dart';
import 'TextLarge.dart';
import 'dart:async';
import 'dart:convert';
import 'TextOakar.dart';

class SuDrawer extends StatelessWidget {
  const SuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0, 128, 0, 1),
            Colors.lightGreen,
          ],
        )),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Center(child: Image.asset('assets/images/logo.png'))),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const SupervisorHome()));
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => const Login()));
              },
            ),
          ],
        ));
  }
}
