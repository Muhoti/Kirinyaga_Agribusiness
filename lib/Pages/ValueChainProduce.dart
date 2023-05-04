// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/MyTextInput.dart';
import 'package:kirinyaga_agribusiness/Components/FODrawer.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Components/TextLarge.dart';
import 'package:kirinyaga_agribusiness/Components/TextOakar.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerHome.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

import '../Components/Utils.dart';

class ValueChainProduce extends StatefulWidget {
  final String vcid;
  final String farmerID;
  final String valuechain;

  const ValueChainProduce(
      {super.key,
      required this.vcid,
      required this.farmerID,
      required this.valuechain});

  @override
  State<ValueChainProduce> createState() => _ValueChainProduceState();
}

class _ValueChainProduceState extends State<ValueChainProduce> {
  String valueChainID = '';
  String valueChain = '';
  String farmerID = '';
  String produceAmount = '';
  String harvestYear = '';
  String harvestMonth = '';
  String season = '';
  String error = '';
  // late DateTime _selectedDate;
  var isLoading;
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    //checkMapping();
    super.initState();
  }

  // checkMapping() async {
  //   try {
  //      farmerID = (await storage.read(key: "NationalID"))!;
  //     editValueChains(farmerID);
  //   } catch (e) {}
  // }

  //  editValueChains(String id) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse("${getUrl()}valuechainproduce/$id"),
  //     );

  //     var body = json.decode(response.body);
  //     print("farmer valuechain body is ${body}");

  //     if (body.length > 0) {
  //       setState(() {
  //         data = body[0];
  //         name = body[0]["Name"];
  //         nationalId = body[0]["NationalID"];
  //         phoneNumber = body[0]["Phone"];
  //         gender = body[0]["Gender"];
  //         age = body[0]["AgeGroup"];
  //         farmingType = body[0]["FarmingType"];
  //       });
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    // String harvestDate = _selectedDate.toString();

    valueChainID = widget.vcid;
    farmerID = widget.farmerID;
    valueChain = widget.valuechain;

    print(
        "the value chain produce id is $valueChainID AND farmer id is $farmerID and valuechain is $valueChain");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Valuechain Produce"),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
        ],
        backgroundColor: Color.fromRGBO(0, 128, 0, 1),
      ),
      drawer: const Drawer(child: FODrawer()),
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextOakar(label: error),
                MyTextInput(
                    title: "Produce Amount",
                    lines: 1,
                    value: "",
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        produceAmount = value;
                      });
                    }),

                MyTextInput(
                    title: "Harvest Year",
                    lines: 1,
                    value: "",
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        harvestYear = value;
                      });
                    }),
                MyTextInput(
                    title: "Harvest Month",
                    lines: 1,
                    value: "",
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        harvestMonth = value;
                      });
                    }),
                MyTextInput(
                    title: "Season",
                    lines: 1,
                    value: "",
                    type: TextInputType.text,
                    onSubmit: (value) {
                      setState(() {
                        season = value;
                      });
                    }),
                // SizedBox(
                //   width: double.infinity,
                //   height: 200,
                //   child: GestureDetector(
                //     onTap: () async {
                //       DateTime? selectedDate = await showCalendar(context);
                //       if (selectedDate != null) {
                //         setState(() {
                //           _selectedDate = selectedDate;
                //         });
                //       }
                //     },
                //     child: TextFormField(
                //       decoration: const InputDecoration(
                //         labelText: 'Date',
                //       ),
                //       readOnly: true,
                //       controller: TextEditingController(
                //         text:
                //             '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(height: 12),
                SubmitButton(
                  label: "Submit",
                  onButtonPressed: () async {
                    setState(() {
                      isLoading = LoadingAnimationWidget.staggeredDotsWave(
                        color: Color.fromRGBO(0, 128, 0, 1),
                        size: 100,
                      );
                    });
                    var res = await postProduce(
                        valueChainID,
                        valueChain,
                        farmerID,
                        produceAmount,
                        harvestYear,
                        harvestMonth,
                        season);

                    setState(() {
                      isLoading = null;
                      if (res.error == null) {
                        error = res.success;
                      } else {
                        error = res.error;
                      }
                    });

                    if (res.error == null) {
                      await storage.write(key: 'erjwt', value: res.token);
                      Timer(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(
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
    );
  }

  // Future<DateTime?> showCalendar(BuildContext context) async {
  //   return await showDialog<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CalendarCarousel(
  //         onDayPressed: (DateTime date, List events) {
  //           Navigator.pop(context, date);
  //         },
  //         selectedDateTime: _selectedDate,
  //       );
  //     },
  //   );
  // }
}

Future<Message> postProduce(
  String valueChainID,
  String valueChain,
  String farmerID,
  String produceAmount,
  String harvestYear,
  String harvestMonth,
  String season,
) async {
  if (produceAmount.isEmpty) {
    return Message(
        token: null, success: null, error: "Please fill all inputs!");
  }

  final response = await http.post(
    Uri.parse("${getUrl()}valuechainproduce/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'ValueChainID': valueChainID,
      'ValueChain': valueChain,
      'FarmerID': farmerID,
      'ProduceAmount': produceAmount,
      'HarvestYear': harvestYear,
      'HarvestMonth': harvestMonth,
      'season': season,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 203) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Message.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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
