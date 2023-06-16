import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ValueChainForm extends StatefulWidget {
  @override
  _ValueChainFormState createState() => _ValueChainFormState();
}

class _ValueChainFormState extends State<ValueChainForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedValueChain;
  late Map questionMap;

  List<String> valueChains = [
    'Tomato',
    'Banana',
    'Avocado',
    'Tomato Seedlings',
    'Chicken (Eggs & Meat)',
    'Chicken (Egg Incubation)',
    'Dairy',
    'Dairy Goat',
    'Apiculture',
    'Pigs',
    'Fish'
  ];

  Map<String, TextEditingController> textControllers = {};

  // Tomato answers
  String? tomatoQ1;
  String? tomatoQ2;
  String? tomatoQ3;
  String? tomatoQ4;
  String? tomatoQ5;
  String? tomatoQ6;
  String? tomatoQ7;
  String? tomatoQ8;
  String? tomatoQ9;
  String? tomatoQ10;
  String? tomatoQ11;
  String? tomatoQ12;
  String? tomatoQ13;
  String? tomatoQ14;
  String? tomatoQ15;
  String? tomatoQ16;
  String? tomatoQ17;

  // Avocado Answers
  String? avocadoQ1;
  String? avocadoQ2;
  String? avocadoQ3;
  String? avocadoQ4;
  String? avocadoQ5;
  String? avocadoQ6;
  String? avocadoQ7;
  String? avocadoQ8;
  String? avocadoQ9;

  // Tomato Seedling answers
  String? tomSeedlingQ1;
  String? tomSeedlingQ2;
  String? tomSeedlingQ3;
  String? tomSeedlingQ4;
  String? tomSeedlingQ5;
  String? tomSeedlingQ6;
  String? tomSeedlingQ7;
  String? tomSeedlingQ8;

  // Chicken Eggs & Meat answers
  String? cemQ1;
  String? cemQ2;
  String? cemQ3;
  String? cemQ4;
  String? cemQ5;
  String? cemQ6;
  String? cemQ7;
  String? cemQ8;
  String? cemQ9;
  String? cemQ10;
  String? cemQ11;
  String? cemQ12;
  String? cemQ13;
  String? cemQ14;

  // Chicken Egg Incubation answers
  String? ceiQ1;
  String? ceiQ2;
  String? ceiQ3;
  String? ceiQ4;
  String? ceiQ5;
  String? ceiQ6;
  String? ceiQ7;
  String? ceiQ8;
  String? ceiQ9;
  String? ceiQ10;

  // Dairy answers
  String? dairyQ1;
  String? dairyQ2;
  String? dairyQ3;
  String? dairyQ4;
  String? dairyQ5;
  String? dairyQ6;
  String? dairyQ7;
  String? dairyQ8;
  String? dairyQ9;
  String? dairyQ10;

  // Dairy Goat answers
  String? dGoatQ1;
  String? dGoatQ2;
  String? dGoatQ3;
  String? dGoatQ4;
  String? dGoatQ5;
  String? dGoatQ6;
  String? dGoatQ7;
  String? dGoatQ8;
  String? dGoatQ9;
  String? dGoatQ10;

  // Apiculture answers
  String? apicQ1;
  String? apicQ2;
  String? apicQ3;
  String? apicQ4;
  String? apicQ5;
  String? apicQ6;
  String? apicQ7;
  String? apicQ8;
  String? apicQ9;
  String? apicQ10;

  // Pigs answers
  String? pigQ1;
  String? pigQ2;
  String? pigQ3;
  String? pigQ4;
  String? pigQ5;
  String? pigQ6;
  String? pigQ7;
  String? pigQ8;
  String? pigQ9;
  String? pigQ10;
  String? pigQ11;
  String? pigQ12;

  // Fish answers
  String? fishQ1;
  String? fishQ2;
  String? fishQ3;
  String? fishQ4;
  String? fishQ5;
  String? fishQ6;
  String? fishQ7;
  String? fishQ8;
  String? fishQ9;
  String? fish10;
  String? fish11;
  String? fish12;
  String? fish13;
  String? fish14;
  String? fish15;
  String? fish16;

  List<Widget> buildQuestionFields() {
    questionMap = initializeQuestionMap();
    List<String> questions = questionMap[selectedValueChain]!;
    List<Widget> questionFields = [];

    for (String question in questions) {
      if (!textControllers.containsKey(question)) {
        textControllers[question] = TextEditingController();
      }

      // Tomato
      if (selectedValueChain == 'Tomato') {
        if (question == questionMap['Tomato']![0]) {
          tomatoQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![1]) {
          tomatoQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![2]) {
          tomatoQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![3]) {
          tomatoQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![4]) {
          tomatoQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![5]) {
          tomatoQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![6]) {
          tomatoQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![7]) {
          tomatoQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![8]) {
          tomatoQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![9]) {
          tomatoQ10 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![10]) {
          tomatoQ11 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![11]) {
          tomatoQ12 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![12]) {
          tomatoQ13 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![13]) {
          tomatoQ14 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![15]) {
          tomatoQ15 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![16]) {
          tomatoQ16 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato']![17]) {
          tomatoQ17 = textControllers[question]!.text;
        }
      }
      // Tomato Seedlings
      else if (selectedValueChain == 'Tomato Seedlings') {
        if (question == questionMap['Tomato Seedlings']![0]) {
          tomSeedlingQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![1]) {
          tomSeedlingQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![2]) {
          tomSeedlingQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![3]) {
          tomSeedlingQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![4]) {
          tomSeedlingQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![5]) {
          tomSeedlingQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![6]) {
          tomSeedlingQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Tomato Seedlings']![7]) {
          tomSeedlingQ8 = textControllers[question]!.text;
        }
      }
      // Avocado
      else if (selectedValueChain == 'Avocado') {
        // Avocado
        if (question == questionMap['Avocado']![0]) {
          avocadoQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![1]) {
          avocadoQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![2]) {
          avocadoQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![3]) {
          avocadoQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![4]) {
          avocadoQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![5]) {
          avocadoQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![6]) {
          avocadoQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![7]) {
          avocadoQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Avocado']![8]) {
          avocadoQ9 = textControllers[question]!.text;
        }
      }
      // Chicken for Eggs and Meat
      else if (selectedValueChain == 'Chicken (Eggs & Meat)') {
        if (question == questionMap['Chicken (Eggs & Meat)']![0]) {
          cemQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![1]) {
          cemQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![2]) {
          cemQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![3]) {
          cemQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![4]) {
          cemQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![5]) {
          cemQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![6]) {
          cemQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![7]) {
          cemQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![8]) {
          cemQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![9]) {
          cemQ10 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![10]) {
          cemQ11 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![11]) {
          cemQ12 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![12]) {
          cemQ13 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Eggs & Meat)']![13]) {
          cemQ14 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Chicken (Egg Incubation)') {
        if (question == questionMap['Chicken (Egg Incubation)']![0]) {
          ceiQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![1]) {
          ceiQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![2]) {
          ceiQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![3]) {
          ceiQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![4]) {
          ceiQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![5]) {
          ceiQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![6]) {
          ceiQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![7]) {
          ceiQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![8]) {
          ceiQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![9]) {
          ceiQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Chicken (Egg Incubation)']![9]) {
          ceiQ10 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Dairy') {
        if (question == questionMap['Dairy']![0]) {
          dairyQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![1]) {
          dairyQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![2]) {
          dairyQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![3]) {
          dairyQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![4]) {
          dairyQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![5]) {
          dairyQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![6]) {
          dairyQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![7]) {
          dairyQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![8]) {
          dairyQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy']![9]) {
          dairyQ10 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Dairy Goat') {
        if (question == questionMap['Dairy Goat']![0]) {
          dGoatQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![1]) {
          dGoatQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![2]) {
          dGoatQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![3]) {
          dGoatQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![4]) {
          dGoatQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![5]) {
          dGoatQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![6]) {
          dGoatQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![7]) {
          dGoatQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![8]) {
          dGoatQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Dairy Goat']![9]) {
          dGoatQ10 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Apiculture') {
        if (question == questionMap['Apiculture']![0]) {
          apicQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![1]) {
          apicQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![2]) {
          apicQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![3]) {
          apicQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![4]) {
          apicQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![5]) {
          apicQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![6]) {
          apicQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![7]) {
          apicQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![8]) {
          apicQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Apiculture']![9]) {
          apicQ10 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Pigs') {
        if (question == questionMap['Pigs']![0]) {
          pigQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![1]) {
          pigQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![2]) {
          pigQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![3]) {
          pigQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![4]) {
          pigQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![5]) {
          pigQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![6]) {
          pigQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![7]) {
          pigQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![8]) {
          pigQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![9]) {
          pigQ10 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![10]) {
          pigQ11 = textControllers[question]!.text;
        } else if (question == questionMap['Pigs']![11]) {
          pigQ12 = textControllers[question]!.text;
        }
      } else if (selectedValueChain == 'Fish') {
        if (question == questionMap['Fish']![0]) {
          fishQ1 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![1]) {
          fishQ2 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![2]) {
          fishQ3 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![3]) {
          fishQ4 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![4]) {
          fishQ5 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![5]) {
          fishQ6 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![6]) {
          fishQ7 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![7]) {
          fishQ8 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![8]) {
          fishQ9 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![9]) {
          fish10 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![10]) {
          fish11 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![11]) {
          fish12 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![12]) {
          fish13 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![13]) {
          fish14 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![14]) {
          fish15 = textControllers[question]!.text;
        } else if (question == questionMap['Fish']![15]) {
          fish16 = textControllers[question]!.text;
        }
      }

      switch (selectedValueChain) {
        case 'Banana':
          if (question == questionMap['Banana']![0] ||
              question == questionMap['Banana']![1]) {
            List<String> options;

            if (question == questionMap['Banana']![0]) {
              options = ['Option 1', 'Option 2', 'Option 3'];
            } else {
              options = ['Option A', 'Option B', 'Option C'];
            }

            questionFields.add(
              DropdownButtonFormField(
                value: textControllers[question]!.text.isNotEmpty
                    ? textControllers[question]!.text
                    : null,
                items: options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    textControllers[question]!.text = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: question),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
            );
          } else {
            questionFields.add(
              TextFormField(
                controller: textControllers[question],
                decoration: InputDecoration(labelText: question),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
            );
          }
          break;

        case 'Tomato':
          if (question == questionMap['Tomato']![0]) {
            List<String> options;
            options = ['Open Field', 'Green House'];

            questionFields.add(
              DropdownButtonFormField(
                value: textControllers[question]!.text.isNotEmpty
                    ? textControllers[question]!.text
                    : null,
                items: options.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    textControllers[question]!.text = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: question),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an option';
                  }
                  return null;
                },
              ),
            );
          } else {
            questionFields.add(
              TextFormField(
                controller: textControllers[question],
                decoration: InputDecoration(labelText: question),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
              ),
            );
          }
          break;

        default:
          questionFields.add(
            TextFormField(
              controller: textControllers[question],
              decoration: InputDecoration(labelText: question),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
          );
          break;
      }
    }

    return questionFields;
  }

  @override
  void dispose() {
    // Dispose of the text controllers
    for (TextEditingController controller in textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Chain Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField(
                  value: selectedValueChain,
                  items: valueChains.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValueChain = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: 'Value Chain'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a value chain';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                if (selectedValueChain != null) ...buildQuestionFields(),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data here
                      for (String question
                          in questionMap[selectedValueChain]!) {
                        String answer = textControllers[question]!.text;
                        print(' $selectedValueChain, ${textControllers[question]!.text}');
                        submitValueChainsData(selectedValueChain, answer);
                      }
                      // Reset the form
                      _formKey.currentState!.reset();
                      setState(() {
                        selectedValueChain = null;
                      });
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Map<String, List<String>> initializeQuestionMap() {
    // Tomato Questions
    String tq1 = "How do you grow your tomatoes (open field or green house?)";
    String tq2 =
        "If open field,What is the area under cultivation for tomatoes?";
    String tq3 =
        'If green house; how many green hosues &  what is the size of your green house?';
    String tq4 = 'Do you use irrigation?';
    String tq5 = 'Type of irrigation used?';
    String tq6 = 'Varieties';
    String tq7 = 'What is the cost of inputs used?';
    String tq8 = 'What are the Kgs of tomatoes produced?';
    String tq9 = 'What are the Kgs of spoilt tomatoes?';
    String tq10 = 'What are the Kgs of tomatoes consumed at home?';
    String tq11 = 'What are the Kgs of tomatoes sold?';
    String tq12 = 'What is the average price of 1kg of tomatoes?';
    String tq13 = 'What is the income from tomatoes?';
    String tq14 =
        'Did you sell your tomatoes through PO? If not whom did you sell to?';

    // Banana Questions
    String bq1 = "Question 1";
    String bq2 = "Question 2";

    // Avocado Questions
    String aq1 = "What is the area under avocado (in acres)?";
    String aq2 = "How many trees do you have?";
    String aq3 = "How many Kgs of avocado produced?";
    String aq4 = "How many Kgs of spoiled avocado?";
    String aq5 = "What is the number of avocado consumed at home in Kg?";
    String aq6 = "What is the average price per Kg?";
    String aq7 = "What is the income from Avocado?";
    String aq8 = "Which PO do you sell through?";
    String aq9 = "Whom did you sell the avocado to?";

    // Tomato Seedling Questions
    String tsq1 = "What is the capacity of your nursery?";
    String tsq2 = "What is the Initial cost of Investment?";
    String tsq3 = "What is the cost of input used?";
    String tsq4 = "What is the number of seedlings produced?";
    String tsq5 = "What is the number of spoilt seedlings?";
    String tsq6 = "What is the number of seedlings sold?";
    String tsq7 = "What is the average price of a seedling?";
    String tsq8 = "Whom do you sell your seedlings to?";

    // Chicken Eggs & Meat questions
    String ceq1 = "How many birds do you have?";
    String ceq2 = "What is the number of birds in egg production?";
    String ceq3 = "What is the number of eggs produced?";
    String ceq4 = "What is the number of spoilt eggs?";
    String ceq5 = "What is the number off eggs Sold?";
    String ceq6 = "What is the average price per egg sold?";
    String ceq7 = "What is the income from eggs sold?";
    String ceq8 = "What is the number of birds consumed at home?";
    String ceq9 = "What is the number of dead birds?";
    String ceq10 = "What is the number of Birds Sold?";
    String ceq11 = "What is the average price per bird sold?";
    String ceq12 = "What is the income from Birds sold?";
    String ceq13 = "Who do you sell eggs to?";
    String ceq14 = "Whom do you sell chicken to?";

    // Chicken for Meat questions
    String cei1 = 'What is the Initial cost of investment?';
    String cei2 = 'How many incubators do you have?';
    String cei3 = 'What is the capacity of the incubator?';
    String cei4 = 'What is the number of eggs incubated?';
    String cei5 = 'What is the number of spoilt eggs?';
    String cei6 = 'What is the number of chicks hatched?';
    String cei7 = 'What is the number of dead chicks?';
    String cei8 = 'What is the number of chicks sold?';
    String cei9 = 'What is the average price per chick sold?';
    String cei10 = 'What is the income from the chicks sold?';

    // Questions for dairy
    String d1 = "How many cows do you have?";
    String d2 = "What is the number of cows in production?";
    String d3 = "How many liters do the cow(s) produce (total)?";
    String d4 =
        "How many liters are consumed at home (total for the reporting period)?";
    String d5 = "What is the average price of 1 liter of milk sold?";
    String d6 = "How many liters of milk were sold?";
    String d7 = "What is the number of calves?";
    String d8 = "What is the number of calves sold?";
    String d9 = "What is the average price per calf sold?";
    String d10 = "What is the income from calves sold?";

    // Questions for dairy goat
    String dg1 = "How many does do you have?";
    String dg2 = "What is the number of does in milk production?";
    String dg3 = "How many liters of milk does the doe(s) produce in total?";
    String dg4 =
        "How many liters are consumed at home for the reporting period?";
    String dg5 = "What is the average price of 1 liter of milk sold?";
    String dg6 = "How many liters of milk were Sold?";
    String dg7 =
        "What is the number of kids kidded? (Factor in those that give birth twins, triplets)";
    String dg8 = "What is the number of kids sold?";
    String dg9 = "What is the average price per kid sold?";
    String dg10 = "What is the income from kids sold?";

// Questions for bees
    String ap1 = "What type and no. of hive per do you have?";
    String ap2 = "How many hives have been colonized?";
    String ap3 = "Have you harvested honey during the reporting period?";
    String ap4 = "How many Kgs of crude honey?";
    String ap5 = "How many Kgs of refined honey?";
    String ap6 = "How many Kgs have you sold during the reporting period?";
    String ap7 = "How much did you sell a Kg at?";
    String ap8 = "What is the income gained from sale of honey?";
    String ap9 = "Is there any other hive product you sell apart from honey?";
    String ap10 = "What is the income generated from the same?";

// Questions for pigs
    String p1 = "How many pigs do you have excluding piglets?";
    String p2 = "How many sows do you have?";
    String p3 = "How many sows are in production?";
    String p4 = "How many piglets do you have?";
    String p5 = "How many piglets have you sold during the reporting period?";
    String p6 = "How much did you sell per piglet?";
    String p7 =
        "How many mature pigs have you sold during the reporting period?";
    String p8 = "Whom did you sell the mature pigs to?";
    String p9 =
        "What's the income gained from the sale of both mature pigs and piglets?";
    String p10 = "How many pigs have you slaughtered for meat?";
    String p11 = "What's the income from the sale of meat?";
    String p12 = "Where did you sell meat or to whom?";

    // Questions for fish
    String f1 = "How many ponds do you have?";
    String f2 = "What's the capacity of each pond?";
    String f3 = "What fish species are you currently rearing?";
    String f4 = "What was the initial stocking of fingerlings?";
    String f5 = "How many kgs have you harvested during the reporting period?";
    String f6 = "What feed do you use?";
    String f7 = "Where do you source your feeds?";
    String f8 = "How much have you spent on feeds during the reporting period?";
    String f9 = "How much did you sell the fish per Kg?";
    String f10 =
        "How many pieces have you sold during the reporting period (for ornamental fish)?";
    String f11 = "Do you have an organized market structure?";
    String f12 =
        "What's the income from sale of fish during the reporting period?";
    String f13 = "Are you a breeder?";
    String f14 = "If yes, are you licensed?";
    String f15 = "What is the selling cost of your fingerlings?";
    String f16 = "How many have you sold during the reporting period?";
    String f17 = "What's the income from the sale of fingerlings?";

    return {
      "Tomato": [
        tq1,
        tq2,
        tq3,
        tq4,
        tq5,
        tq6,
        tq7,
        tq8,
        tq9,
        tq10,
        tq11,
        tq12,
        tq13,
        tq14
      ],
      "Banana": [bq1, bq2],
      "Avocado": [aq1, aq2, aq3, aq4, aq5, aq6, aq7, aq8, aq9],
      "Tomato Seedlings": [tsq1, tsq2, tsq3, tsq4, tsq5, tsq6, tsq7, tsq8],
      "Chicken (Eggs & Meat)": [
        ceq1,
        ceq2,
        ceq3,
        ceq4,
        ceq5,
        ceq6,
        ceq7,
        ceq8,
        ceq9,
        ceq10,
        ceq11,
        ceq12,
        ceq13,
        ceq14
      ],
      "Chicken (Egg Incubation)": [
        cei1,
        cei2,
        cei3,
        cei4,
        cei5,
        cei6,
        cei7,
        cei8,
        cei9,
        cei10
      ],
      "Dairy": [d1, d2, d3, d4, d5, d6, d7, d8, d9, d10],
      "Dairy Goat": [dg1, dg2, dg3, dg4, dg5, dg6, dg7, dg8, dg9, dg10],
      "Apiculture": [ap1, ap2, ap3, ap4, ap5, ap6, ap7, ap8, ap9, ap10],
      "Pigs": [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12],
      "Fish": [
        f1,
        f2,
        f3,
        f4,
        f5,
        f6,
        f7,
        f8,
        f9,
        f10,
        f11,
        f12,
        f13,
        f14,
        f15,
        f16,
        f17
      ],
    };
  }
}

void submitValueChainsData(String selectedValueChain, String answer) {

}
