import 'package:kirinyaga_agribusiness/Pages/FarmerDetails.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerInfo.dart';
import 'package:kirinyaga_agribusiness/Pages/Produce.dart';
import 'package:kirinyaga_agribusiness/main.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
            Colors.green,
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
                'Farmer Home',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const FarmerHome()));
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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const FarmerDetails()));
              },
            ),
            ListTile(
              title: Text(
                'Update Produce',
                style: style,
              ),
              onTap: () {
                final store = new FlutterSecureStorage();
                store.deleteAll();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => const Produce()));
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
                    context, MaterialPageRoute(builder: (_) => const FarmerInfo()));
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
