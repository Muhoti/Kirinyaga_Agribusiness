import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyCalendar.dart';
import 'package:kirinyaga_agribusiness/Components/MySelectInput.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Components/Utils.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Fish extends StatefulWidget {
  final bool editing;

  const Fish({super.key, required this.editing});

  @override
  State<Fish> createState() => _FishState();
}

class _FishState extends State<Fish> {
  final storage = const FlutterSecureStorage();
  String error = '';
  var isLoading;
  String farmerID = '';
  String valueChain = 'Fish';
  String landsize = '';
  String startPeriod = '';
  String endPeriod = '';
  String ponds = '';
  String capacity = '';
  String fishspecies = '';
  String initialfingerlings = '';
  String initialfingerlingsprice = '';
  String totalharvested = '';
  String feeds = '';
  String feedssource = '';
  String feedscost = '';
  String fishprice = '';
  String fishsold = '';
  String marketstructure = 'Yes';
  String income = '';
  String breeder = 'Yes';
  String license = 'Yes';
  String fingerlingscost = '';
  String fingerlingssold = '';
  String fingerlingsincome = '';

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
        print(farmerID);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    MyTextInput(
                        title: "Total Land Size",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            landsize = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCalendar(
                      label: "Start Period",
                      onSubmit: (value) {
                        setState(() {
                          startPeriod = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCalendar(
                      label: "End Period",
                      onSubmit: (value) {
                        setState(() {
                          endPeriod = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Ponds",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            ponds = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Capacity per Pond",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            capacity = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Type of Fish Species",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            fishspecies = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Initial Stocking of Fingerlings",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            initialfingerlings = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Cost for Initial Fingerlings",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            initialfingerlingsprice = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Amount of Fish Harvested (KGs)",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            totalharvested = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Type of Feed Used",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            feeds = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Source of Feed Source",
                        lines: 1,
                        value: "",
                        type: TextInputType.text,
                        onSubmit: (value) {
                          setState(() {
                            feedssource = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Feeds Cost",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            feedscost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Fish Price per KG",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            fishprice = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Fish Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            fishsold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Organized Market Structure",
                        onSubmit: (selectedFarmingType) {
                          setState(() {
                            marketstructure = selectedFarmingType;
                          });
                        },
                        entries: const ["Yes", "No"],
                        value: marketstructure),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Income From Fish Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            income = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "Are you a breeder?",
                        onSubmit: (breederoption) {
                          setState(() {
                            breeder = breederoption;
                          });
                        },
                        entries: const ["Yes", "No"],
                        value: breeder),
                    const SizedBox(
                      height: 10,
                    ),
                    MySelectInput(
                        title: "If yes, are you licensed?",
                        onSubmit: (licensedbreeder) {
                          setState(() {
                            license = licensedbreeder;
                          });
                        },
                        entries: const ["Yes", "No"],
                        value: breeder),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Price of Fingerlings",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            fingerlingscost = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Number of Fingerlings Sold",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            fingerlingssold = value;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                        title: "Income From Sale of Fingerlings",
                        lines: 1,
                        value: "",
                        type: TextInputType.number,
                        onSubmit: (value) {
                          setState(() {
                            fingerlingsincome = value;
                          });
                        }),
                    TextOakar(label: error),
                    SubmitButton(
                      label: "Submit",
                      onButtonPressed: () async {
                        setState(() {
                          isLoading = LoadingAnimationWidget.staggeredDotsWave(
                            color: Color.fromRGBO(0, 128, 0, 1),
                            size: 100,
                          );
                        });
                        var res = await submitData(
                            widget.editing,
                            farmerID,
                            valueChain,
                            landsize,
                            startPeriod,
                            endPeriod,
                            ponds,
                            capacity,
                            fishspecies,
                            initialfingerlings,
                            initialfingerlingsprice,
                            totalharvested,
                            feeds,
                            feedssource,
                            feedscost,
                            fishprice,
                            fishsold,
                            marketstructure,
                            income,
                            breeder,
                            license,
                            fingerlingscost,
                            fingerlingssold,
                            fingerlingsincome);

                        setState(() {
                          isLoading = null;
                          if (res.error == null) {
                            error = res.success;
                          } else {
                            error = res.error;
                          }
                        });

                        if (res.error == null) {
                          Timer(const Duration(seconds: 2), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FarmerValueChains()));
                          });
                        }
                      },
                    ),
                  ],
                ),
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

submitData(
    bool type,
    String farmerID,
    String valueChain,
    String landsize,
    String startPeriod,
    String endPeriod,
    String ponds,
    String capacity,
    String fishspecies,
    String initialfingerlings,
    String initialfingerlingsprice,
    String totalharvested,
    String feeds,
    String feedssource,
    String feedscost,
    String fishprice,
    String fishsold,
    String marketstructure,
    String income,
    String breeder,
    String license,
    String fingerlingscost,
    String fingerlingssold,
    String fingerlingsincome) async {
  if (valueChain.isEmpty ||
      ponds.isEmpty ||
      capacity.isEmpty ||
      fishspecies.isEmpty ||
      initialfingerlings.isEmpty ||
      totalharvested.isEmpty ||
      initialfingerlingsprice.isEmpty ||
      feedssource.isEmpty ||
      fishprice.isEmpty ||
      fishsold.isEmpty ||
      marketstructure.isEmpty ||
      income.isEmpty ||
      breeder.isEmpty ||
      license.isEmpty ||
      fingerlingscost.isEmpty ||
      fingerlingssold.isEmpty ||
      fingerlingsincome.isEmpty) {
    return Message(
        token: null, success: null, error: "All fields are required!");
  }

  try {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: "erjwt");
    var response;

    if (type) {
      response = await http.post(Uri.parse("${getUrl()}valuechainproduce"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token!
          },
          body: jsonEncode(<String, String>{
            'FarmerID': farmerID,
            'ValueChainName': valueChain,
            'LandSize': landsize,
            'PeriodStart': startPeriod,
            'PeriodEnd': endPeriod,
            'Ponds': ponds,
            'Capacity': capacity,
            'FishSpecies': fishspecies,
            'InitialFingerlings': initialfingerlings,
            'TotalHarvested': totalharvested,
            'Feeds': initialfingerlingsprice,
            'FeedsSource': feedssource,
            'FeedsCost': feedscost,
            'FishPrice': fishprice,
            'FishSold': fishsold,
            'MarketStructure': marketstructure,
            'Income': income,
            'Breeder': breeder,
            'License': license,
            'FingerlingsCost': fingerlingscost,
            'FingerlingsSold': fingerlingssold,
            'FingerlingsIncome': fingerlingsincome
          }));
    } else {
      response = await http.post(Uri.parse("${getUrl()}fish"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'token': token!
          },
          body: jsonEncode(<String, String>{
            'FarmerID': farmerID,
            'ValueChainName': valueChain,
            'LandSize': landsize,
            'PeriodStart': startPeriod,
            'PeriodEnd': endPeriod,
            'Ponds': ponds,
            'Capacity': capacity,
            'FishSpecies': fishspecies,
            'InitialFingerlings': initialfingerlings,
            'TotalHarvested': totalharvested,
            'Feeds': initialfingerlingsprice,
            'FeedsSource': feedssource,
            'FeedsCost': feedscost,
            'FishPrice': fishprice,
            'FishSold': fishsold,
            'MarketStructure': marketstructure,
            'Income': income,
            'Breeder': breeder,
            'License': license,
            'FingerlingsCost': fingerlingscost,
            'FingerlingsSold': fingerlingssold,
            'FingerlingsIncome': fingerlingsincome
          }));
    }

    if (response.statusCode == 200 || response.statusCode == 203) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      return Message(
        token: null,
        success: null,
        error: "Connection to server failed!",
      );
    }
  } catch (e) {
    return Message(
      token: null,
      success: null,
      error: "Connection to server failed!",
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
