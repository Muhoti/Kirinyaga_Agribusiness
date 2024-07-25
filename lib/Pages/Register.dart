// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/Login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String name = '';
  String email = '';
  String phone = '';
  String department = '';
  String designation = '';
  String deployment = '';
  String station = '';
  String level = '';
  String levelname = '';
  String role = '';
  String gender = '';
  String password = '';
  String confirmpass = '';
  String error = '';
  var isLoading;
  final storage = const FlutterSecureStorage();
  String nationalId = '';
  dynamic data;
  
  var levelList = {
    "Select Level": ["Select Level Name"],
    "County": ["Kirinyaga"],
    "Sub County": [
      "Kirinyaga East",
      "Kirinyaga West",
      "Mwea East",
      "Mwea West",
      "Kirinyaga Central"
    ],

    "Ward": [
      "Mutithi",
      "Kangai",
      "Wamumu",
      "Nyangati",
      "Murindiko",
      "Gathigiriri",
      "Tebere",
      "Kabare Baragwi",
      "Kanyekini",
      "Kerugoya",
      "Inoi",
      "Mukurwe",
      "Kiine",
      "Kariti"
    ]
  };

  var levelNameList = {
    "Select Level": ["Select Role"],
    "County": [
      "County Executive Committee Memer",
      "Chief Officer",
      "County Director Agriculture",
      "County Director Livestock Veterinary & Fisheries",
      "CECM Office Administrator",
      "County SMS",
      "Head of Department",
      "CO Office Administrator",
      "Fleet Manager",
      "Head of CASIMU",
      "ICT/Admin",
      "Office Administrator",
      "Driver"
    ],

    "Sub County": [
      "SCAO",
      "SCLPO",
      "SCVO",
      "SCFO",
      "Office Administrator",
      "Drivers",
      "Support Staff"
    ],
    
    "Ward": ["WAEO", "WLPO", "WAHO", "Meat Inspector"],
  };

  List<String> levelNameList1 = [];
  List<String> roleList = [];

  updateLevelName(v) {
    setState(() {
      levelname = levelList[v]!.toList()[0];
      levelNameList1 = levelList[v]!.toList();
    });
  }

  updateRole(v) {
    setState(() {
      role = levelNameList[v]!.toList()[0];
      roleList = levelNameList[v]!.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Field Officer Registration",
      home: Scaffold(
          key: _scaffoldKey,
          body: Stack(children: [
            Container(
                constraints: const BoxConstraints.tightForFinite(),
                child: SingleChildScrollView(
                  child: Form(
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(84, 24, 84, 12),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const TextLarge(label: "Staff Registration"),
                        MyTextInput(
                          title: 'Name',
                          lines: 1,
                          value: '',
                          type: TextInputType.name,
                          onSubmit: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
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
                          title: 'Phone',
                          lines: 1,
                          value: '',
                          type: TextInputType.phone,
                          onSubmit: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Department',
                          lines: 1,
                          value: '',
                          type: TextInputType.text,
                          onSubmit: (value) {
                            setState(() {
                              department = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Designation',
                          lines: 1,
                          value: '',
                          type: TextInputType.text,
                          onSubmit: (value) {
                            setState(() {
                              designation = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Deployment',
                          lines: 1,
                          value: '',
                          type: TextInputType.text,
                          onSubmit: (value) {
                            setState(() {
                              deployment = value;
                            });
                          },
                        ),
                        MyTextInput(
                          title: 'Duty Station',
                          lines: 1,
                          value: '',
                          type: TextInputType.text,
                          onSubmit: (value) {
                            setState(() {
                              station = value;
                            });
                          },
                        ),
                        MySelectInput(
                          onSubmit: (value) {
                            setState(() {
                              level = value;
                            });
                            updateLevelName(value);
                            updateRole(value);
                          },
                          entries: levelList.keys.toList(),
                          value: data == null ? level : data["Level"],
                          title: 'Level',
                        ),
                        MySelectInput(
                          onSubmit: (value) {
                            setState(() {
                              levelname = value;
                            });
                          },
                          entries: levelNameList1,
                          value: data == null ? levelname : data["LevelName"],
                          title: 'Level Name',
                        ),
                        MySelectInput(
                          onSubmit: (value) {
                            setState(() {
                              role = value;
                            });
                          },
                          entries: roleList,
                          value: data == null ? role : data["Role"],
                          title: 'Role',
                        ),
                        MySelectInput(
                          title: "Gender",
                          onSubmit: (newValue) {
                            setState(() {
                              error = "";
                              gender = newValue;
                            });
                          },
                          entries: const [
                            "--Select Gender--",
                            "Male",
                            "Female"
                          ],
                          value: gender,
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
                        MyTextInput(
                          title: 'Confirm Password',
                          lines: 1,
                          value: '',
                          type: TextInputType.visiblePassword,
                          onSubmit: (value) {
                            setState(() {
                              confirmpass = value;
                            });
                          },
                        ),
                        TextOakar(label: error),
                        SubmitButton(
                          label: "Register",
                          onButtonPressed: () async {
                            setState(() {
                              isLoading =
                                  LoadingAnimationWidget.staggeredDotsWave(
                                color: const Color.fromRGBO(0, 128, 0, 1),
                                size: 100,
                              );
                            });
                            var res = await submitData(
                                name,
                                email,
                                phone,
                                department,
                                designation,
                                deployment,
                                station,
                                level,
                                levelname,
                                role,
                                gender,
                                password,
                                confirmpass);
                            setState(() {
                              isLoading = null;
                              if (res.error == null) {
                                error = res.success;
                              } else {
                                error = res.error;
                              }
                            });
                            if (res.error == null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const Login()));
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const TextOakar(
                            label: "Powered by \n Oakar Services Ltd.")
                      ]))),
                )),
            Center(child: isLoading),
          ])),
    );
  }
}

Future<Message> submitData(
  String name,
  String email,
  String phone,
  String department,
  String designation,
  String deployment,
  String station,
  String level,
  String levelname,
  String role,
  String gender,
  String password,
  String confirmpass,
) async {
  if (name.isEmpty ||
      email.isEmpty ||
      phone.isEmpty ||
      department.isEmpty ||
      designation.isEmpty ||
      deployment.isEmpty ||
      station.isEmpty ||
      level.isEmpty ||
      levelname.isEmpty ||
      role.isEmpty ||
      gender.isEmpty ||
      password.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }

  if (password != confirmpass) {
    return Message(token: null, success: null, error: "Password mismatch!!");
  }

  print("email is: $email, password is: $password");
  try {
    print("begining login");
    final response = await http.post(
      Uri.parse("${getUrl()}mobile/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Name': name,
        'Email': email,
        'Phone': phone,
        'Department': department,
        'Position': designation,
        'Deployment': deployment,
        'DutyStation': station,
        'Level': level,
        'LevelName': levelname,
        'Role': role,
        'Gender': gender,
        'Password': password,
      }),
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
