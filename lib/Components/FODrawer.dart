import 'package:kirinyaga_agribusiness/Components/SearchFarmer.dart';
import 'package:kirinyaga_agribusiness/Pages/Account.dart';
import 'package:kirinyaga_agribusiness/Pages/FOWorkPlanStats.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Pages/SUPWorkPlanStats.dart';
import 'package:kirinyaga_agribusiness/Pages/Schedule.dart';
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
import 'package:flutter/material.dart';

class FODrawer extends StatelessWidget {
  const FODrawer({super.key});

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
            Color.fromRGBO(0, 128, 0, 1),
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
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FieldOfficerHome()));
              },
            ),
            ListTile(
              title: const Text(
                'My Activities',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Schedule()));
              },
            ),
            ListTile(
              title: const Text(
                'WorkPlans',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FOWorkPlanStats()));
              },
            ),
            ListTile(
              title: const Text(
                'Map Farmer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
            ListTile(
              title: const Text(
                'Update Farmer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SearchFarmer();
                  },
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Account()));
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
