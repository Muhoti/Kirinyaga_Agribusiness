import 'package:flutter/material.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerLogin.dart';
import 'package:kirinyaga_agribusiness/Pages/StaffLogin.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: PageView(
        children: const [FarmerLogin(), StaffLogin()],
        onPageChanged: (index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
      //bottomNavigationBar: BottomNavigationBar(),
    );
  }
}
