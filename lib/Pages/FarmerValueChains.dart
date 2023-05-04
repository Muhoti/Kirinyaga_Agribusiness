import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/AddValueChain.dart';
import 'package:kirinyaga_agribusiness/Pages/ValueChainProduce.dart';
import 'package:kirinyaga_agribusiness/Pages/Summary.dart';
import 'package:kirinyaga_agribusiness/Scroll/FGScrollController.dart';
import 'package:kirinyaga_agribusiness/Scroll/VCScrollController.dart';
import '../Components/FODrawer.dart';

class FarmerValueChains extends StatefulWidget {
  const FarmerValueChains({super.key});

  @override
  State<FarmerValueChains> createState() => _FarmerValueChainsState();
}

class _FarmerValueChainsState extends State<FarmerValueChains> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String FarmerID = '';

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
          FarmerID = id;
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kirinyaga Agribusiness',
      home: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Farmer ValueChains"),
            backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
          ),
          drawer: const Drawer(child: FODrawer()),
          body: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: FarmerID != ""
                    ? VCScrollController(id: FarmerID)
                    : const SizedBox(),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                  child: Column(
                    children: [
                      SubmitButton(
                        label: "Add ValueChain",
                        onButtonPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddValueChain(
                                        id: null,
                                      )));
                        },
                      ),
                      SubmitButton(
                        label: "Proceed",
                        onButtonPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Summary()));
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
