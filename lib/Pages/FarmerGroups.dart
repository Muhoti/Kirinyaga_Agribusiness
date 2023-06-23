import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kirinyaga_agribusiness/Components/CreateFarmerGroup.dart';
import 'package:kirinyaga_agribusiness/Components/SubmitButton.dart';
import 'package:kirinyaga_agribusiness/Pages/FarmerValueChains.dart';
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import 'package:kirinyaga_agribusiness/Scroll/FGScrollController.dart';
import '../Components/FODrawer.dart';

class FarmerGroups extends StatefulWidget {
  const FarmerGroups({super.key});

  @override
  State<FarmerGroups> createState() => _FarmerGroupsState();
}

class _FarmerGroupsState extends State<FarmerGroups> {
  final storage = const FlutterSecureStorage();
  String name = '';
  String FarmerID = '';
  String nationalId = '';

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Farmer Associatons"),
          backgroundColor: const Color.fromRGBO(0, 128, 0, 1),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => const Home()))
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 24,),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FarmerID != ""
                  ? FGScrollController(id: FarmerID)
                  : const SizedBox(),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 24),
                child: Column(
                  children: [
                    SubmitButton(
                      label: "Add Farmer Group",
                      onButtonPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateFarmerGroup();
                          },
                        );
                      },
                    ),
                    SubmitButton(
                      label: "Proceed",
                      onButtonPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const FarmerValueChains()));
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
