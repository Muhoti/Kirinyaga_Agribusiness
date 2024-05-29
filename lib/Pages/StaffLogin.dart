// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously
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
import 'package:kirinyaga_agribusiness/Pages/SupervisorHome.dart';
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

  checkSUPActivity(String id) async {
    try {
      final response = await http.get(
        Uri.parse("${getUrl()}activity/getmyactivities/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var data = json.decode(response.body);
      print("activity is $data");
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
    } catch (e) {
      print(e);
    }
  }

  checkRole(token) async {
    try {
      var data = parseJwt(token);
      String role = data["Role"];
      String id = data["UserID"];

      print("role is $role");

      switch (role) {
        case "Field Officer":
          storage.write(key: 'role', value: 'Field Officer');
          checkFOActivity(
            id,
          );

          break;
        case "Supervisor":
          storage.write(key: 'role', value: 'Supervisor');
          checkSUPActivity(
            id,
          );

          break;
        case "Chief Officer":
          storage.write(key: 'role', value: 'Chief Officer');
          checkSUPActivity(
            id,
          );

          break;
        case "County Executive Committee Member":
          storage.write(
              key: 'role', value: 'County Executive Committee Member');
          checkSUPActivity(
            id,
          );

          break;

        case "County Director Agriculture":
          storage.write(key: 'role', value: 'County Director Agriculture');
          checkSUPActivity(
            id,
          );

          break;
        case "County Director Livestock Veterinary & Fisheries":
          storage.write(
              key: 'role',
              value: 'County Director Livestock Veterinary & Fisheries');
          checkSUPActivity(
            id,
          );

          break;

        case "CECM Office Administrator":
          storage.write(key: 'role', value: 'CECM Office Administrator');
          checkFOActivity(
            id,
          );

          break;

        case "County SMS":
          storage.write(key: 'role', value: 'County SMS');
          checkFOActivity(
            id,
          );

          break;

        case "Head of Department":
          storage.write(key: 'role', value: 'Head of Department');
          checkSUPActivity(
            id,
          );

          break;

        case "CO Office Administrator":
          storage.write(key: 'role', value: 'CO Office Administrator');
          checkFOActivity(
            id,
          );
          break;

        case "Fleet Manager":
          storage.write(key: 'role', value: 'Fleet Manager');
          checkFOActivity(
            id,
          );

          break;

        case "Head of CASIMU":
          storage.write(key: 'role', value: 'Head of CASIMU');
          checkSUPActivity(
            id,
          );

          break;

        case "ICT/Admin":
          storage.write(key: 'role', value: 'ICT/Admin');
          checkSUPActivity(
            id,
          );

          break;

        case "Office Administrator":
          storage.write(key: 'role', value: 'Office Administrator');
          checkFOActivity(
            id,
          );

          break;

        case "Driver":
          storage.write(key: 'role', value: 'Driver');
          checkFOActivity(
            id,
          );

          break;

        // Added roles here

        case "SCAO":
          storage.write(key: 'role', value: 'SCAO');
          checkFOActivity(
            id,
          );

          break;

        case "SCLPO":
          storage.write(key: 'role', value: 'SCLPO');
          checkFOActivity(
            id,
          );

          break;

        case "SCVO":
          storage.write(key: 'role', value: 'SCVO');
          checkFOActivity(
            id,
          );

          break;

        case "SCFO":
          storage.write(key: 'role', value: 'SCFO');
          checkFOActivity(
            id,
          );

          break;

        case "Drivers":
          storage.write(key: 'role', value: 'Drivers');
          checkFOActivity(
            id,
          );

          break;

        case "Support Staff":
          storage.write(key: 'role', value: 'Support Staff');
          checkFOActivity(
            id,
          );

          break;

        case "WAEO":
          storage.write(key: 'role', value: 'WAEO');
          checkSUPActivity(
            id,
          );

          break;

        case "WLPO":
          storage.write(key: 'role', value: 'WLPO');
          checkFOActivity(
            id,
          );

          break;

        case "WAHO":
          storage.write(key: 'role', value: 'WAHO');
          checkFOActivity(
            id,
          );

          break;

        case "Meat Inspector":
          storage.write(key: 'role', value: 'Meat Inspector');
          checkFOActivity(
            id,
          );

          break;

        // Added roles above

        case "Enumerator":
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const Home()));
          break;

        default:
          const FieldOfficerHome();
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
                                    color: Color.fromRGBO(0, 128, 0, 1),
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
