import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerAddress.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerInfo.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerResources.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/main.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'TextLarge.dart';
import 'dart:async';
import 'dart:convert';
import 'TextOakar.dart';

class NavigationDrawer2 extends StatelessWidget {
  const NavigationDrawer2({super.key});

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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Home()));
              },
            ),
            ListTile(
              title: const Text(
                'Edit Farmer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const SearchFarmerDialog();
                  },
                );
              },
            ),
            ListTile(
              title: Text(
                'Farmer Details',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FarmerDetails()));
              },
            ),
            ListTile(
              title: Text(
                'Farmer Address',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FarmerAddress()));
              },
            ),
            ListTile(
              title: Text(
                'Farm Resources',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const FarmerResources()));
              },
            ),
            ListTile(
              title: Text(
                'Farmer ValueChain',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FarmerValueChains()));
              },
            ),
            ListTile(
              title: Text(
                'Farmer Information',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FarmerInfo(
                              id: '86d2bbc0-9543-4ac0-bd2d-fa733fe32776',
                            )));
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const MyApp()));
              },
            ),
          ],
        ));
  }
}

class SearchFarmerDialog extends StatelessWidget {
  const SearchFarmerDialog({Key? key}) : super(key: key);
  final storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Search Farmer'),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: '000000',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SubmitButton(
            label: "Search",
            onButtonPressed: () {
              searchFarmer("529874135").then((data) async {
                if (data.data.length > 0) {
                  await storage.write(
                      key: 'NationalID', value: data.data[0]['NationalID']);
                  var id = await storage.read(key: "NationalID");
                  print(id);
                } else {}
              });
            })
      ],
    );
  }
}

Future<Data> searchFarmer(String id) async {
  final response = await http.get(
    Uri.parse("${getUrl()}farmerdetails/farmerid/${id}"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200 || response.statusCode == 203) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    return Data(data: []);
  }
}

class Data {
  List<dynamic> data;

  Data({required this.data});

  factory Data.fromJson(List<dynamic> json) {
    return Data(
      data: json,
    );
  }
}
