import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:kirinyaga_agribusiness/Pages/Home.dart';
import '../Model/SearchItem.dart';
import 'Utils.dart';

class SearchFarmer extends StatefulWidget {
  SearchFarmer({super.key});

  @override
  State<StatefulWidget> createState() => _SearchFarmer();
}

class _SearchFarmer extends State<SearchFarmer> {
  final storage = const FlutterSecureStorage();
  List<SearchItem> entries = <SearchItem>[];
  String error = '';
  String check = '';

  searchFarmer(v) async {
    setState(() {
      entries.clear();
    });
    try {
      final response = await http.get(
          Uri.parse("${getUrl()}workplan/searchfarmer/$v"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      var data = json.decode(response.body);

      setState(() {
        entries.clear();
        for (var item in data) {
          entries.add(SearchItem(item["Name"], item["NationalID"]));
        }
      });
    } catch (e) {
      // todo
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Search Farmer',
          style: TextStyle(color: Colors.green),
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
          child: TextFormField(
              onChanged: (value) {
                if (value.characters.length >= check.characters.length) {
                  searchFarmer(value);
                } else {
                  setState(() {
                    entries.clear();
                  });
                }
                setState(() {
                  check = value;
                  error = '';
                });
              },
              keyboardType: TextInputType.number,
              maxLines: 1,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(0, 128, 0, 1))),
                  filled: false,
                  label: Text(
                    "National ID",
                    style: TextStyle(color: Color.fromRGBO(0, 128, 0, 1)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto)),
        ),
        entries.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Card(
                  elevation: 12,
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ListView.separated(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: entries.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TextButton(
                          onPressed: () {
                            setState(() {
                              storage.write(
                                  key: "NationalID",
                                  value: entries[index].NationalID);
                              entries.clear();
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()));
                          },
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Name: ${entries[index].Name} \n ID: ${entries[index].NationalID}')),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 1,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
