// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously, empty_catches, avoid_print
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/ForgetPasswordDialog.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/CreateActivity.dart';
import 'package:kirinyaga_agribusiness/Pages/FieldOfficerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Pages/Register.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class StaffLogin extends StatefulWidget {
  const StaffLogin({super.key});

  @override
  State<StatefulWidget> createState() => _StaffLoginState();
}

class _StaffLoginState extends State<StaffLogin> {
  String email = '';
  String password = '';
  String error = '';
  var isLoading;
  String role = '';
  final storage = const FlutterSecureStorage();
  String nationalId = '';
  Timer? logoutTimer;

  @override
  void dispose() {
    logoutTimer?.cancel();
    super.dispose();
  }

  void startLogoutTimer() {
    DateTime now = DateTime.now();
    DateTime fivePM = DateTime(now.year, now.month, now.day, 17, 0, 0);

    if (now.isAfter(fivePM)) {
      fivePM = fivePM.add(const Duration(days: 1));
    }

    Duration durationUntilFivePM = fivePM.difference(now);

    logoutTimer?.cancel();
    logoutTimer = Timer(durationUntilFivePM, () {
      storage.deleteAll();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StaffLogin()),
      );
    });
  }

  void stopLogoutTimer() {
    logoutTimer?.cancel();
  }

  checkFOActivity(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}activity/getmyactivities/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(response.body);
      if (data.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CreateActivity(
              userid: id,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const FieldOfficerHome(),
          ),
        );
      }
    } catch (e) {}
  }

  checkRole(token) async {
    try {
      var data = parseJwt(token);
      String role = data["Role"];
      String id = data["UserID"];

      print("role is $role");

      switch (role) {
        case "Enumerator":
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Home()));
          break;

        default:
          checkFOActivity(
            id,
          );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Staff Login",
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: <Widget>[
            Center(
                child: Container(
                    constraints: const BoxConstraints.tightForFinite(),
                    child: SingleChildScrollView(
                      child: Form(
                          child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(84, 24, 84, 12),
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            const TextLarge(label: "Staff Login"),
                            TextOakar(label: error),
                            MyTextInput(
                              title: 'Email',
                              lines: 1,
                              value: '',
                              type: TextInputType.emailAddress,
                              onSubmit: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                            MyTextInput(
                              title: 'Password',
                              lines: 1,
                              value: '',
                              type: TextInputType.visiblePassword,
                              onSubmit: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                            ),
                            SubmitButton(
                              label: "Login",
                              onButtonPressed: () async {
                                setState(() {
                                  isLoading =
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: const Color.fromRGBO(0, 128, 0, 1),
                                    size: 100,
                                  );
                                });
                                var res = await login(email, password);
                                setState(() {
                                  isLoading = null;
                                  if (res.error == null) {
                                    error = res.success;
                                  } else {
                                    error = res.error;
                                  }
                                });
                                if (res.error == null) {
                                  await storage.write(
                                      key: 'erjwt', value: res.token);
                                  await storage.write(
                                      key: 'Type', value: 'Staff');
                                  checkRole(res.token);
                                  startLogoutTimer();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Register()));
                                  },
                                  child: const Text('Register',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 128, 0, 1))),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const ForgetPasswordDialog(),
                                    );
                                  },
                                  child: const Text('Forgot Password?',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromRGBO(0, 128, 0, 1))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const TextOakar(
                                label: "Powered by \n Oakar Services Ltd.")
                          ]))),
                    ))),
            Center(child: isLoading),
          ])),
    );
  }
}

Future<Message> login(String email, String password) async {
 DateTime now = DateTime.now();

  if (now.hour >= 9 && now.hour <= 8) {
    return Message(
      token: null,
      success: null,
      error: "Login is only allowed between 12 AM and 9 AM.",
    );
  }

  if (email.isEmpty || !EmailValidator.validate(email)) {
    return Message(
      token: null,
      success: null,
      error: "Email is invalid!",
    );
  }

  if (password.length < 6) {
    return Message(
      token: null,
      success: null,
      error: "Password is too short!",
    );
  }

  print("email is: $email, password is: $password");
  try {
    print("begining login");
    final response = await http.post(
      Uri.parse("${getUrl()}mobile/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'Email': email, 'Password': password}),
    );

    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 203) {
      print(response.body);
      return Message.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);

      return Message(
        token: null,
        success: null,
        error: "Connection to server failed!",
      );
    }
  } catch (e) {
    print("login error: $e");
    return Message(
      token: null,
      success: null,
      error: "Connection to server failed!!",
    );
  }
}

class Message {
  var token;
  var success;
  var error;

  Message({
    required this.token,
    required this.success,
    required this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      token: json['token'],
      success: json['success'],
      error: json['error'],
    );
  }
}
