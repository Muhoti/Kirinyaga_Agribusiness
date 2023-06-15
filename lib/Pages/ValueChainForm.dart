import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ValueChainForm extends StatefulWidget {
  @override
  _ValueChainFormState createState() => _ValueChainFormState();
}

class _ValueChainFormState extends State<ValueChainForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
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

  String? selectedValueChain;
  String? tomatoVarieties;
  Map<String, List<String>> questionMap = {

    'Tomato': [
      'How do you grow your tomatoes (open field or green house?)',
      'If open field,What is the area under cultivation for tomatoes?',
      'If green house; how many green hosues &  what is the size of your green house?',
      'Do you use irrigation?',
      'Type of irrigation used?',
      'Varieties',
      'What is the cost of inputs used?',
      'What are the Kgs of tomatoes produced?',
      'What are the Kgs of spoilt tomatoes?',
      'What are the Kgs of tomatoes consumed at home?',
      'What are the Kgs of tomatoes sold?',
      'What is the average price of 1kg of tomatoes?',
      'What is the income from tomatoes?',
      'Did you sell your tomatoes through PO? If not whom did you sell to?',
    ],

    'Banana': ['Question 4', 'Question 5'],

    'Avocado': [
      'What is the area under avocado (in acres)?',
      'How many trees do you have?',
      'How many Kgs of avocado produced?',
      'How many Kgs of spoiled avocado?',
      'What is the number of avocado consumed at home in Kg?',
      'What is the average price per Kg?',
      'What is the income from Avocado?',
      'Which PO do you sell through?',
      'Whom did you sell the avocado to?'
    ],

    'Tomato Seedlings': [
      'What is the capacity of your nursery?',
      'What is the Initial cost of Investment?',
      'What is the cost of input used?',
      'What is the number of seedlings produced?',
      'What is the number of spoilt seedlings?',
      'What is the number of seedlings sold?',
      'What is the average price of a seedling?',
      'Whom do you sell your seedlings to?'
    ],

    'Chicken (Eggs & Meat)': [
      'How many birds do you have?',
      'What is the number of birds in egg production?',
      'What is the number of eggs produced?',
      'What is the number of spoilt eggs?',
      'What is the number off eggs Sold?',
      'What is the average price per egg sold?',
      'What is the income from eggs sold?',
      'What is the number of birds consumed at home?',
      'What is the number of dead birds?',
      'What is the number of Birds Sold?',
      'What is the average price per bird sold?',
      'What is the income from Birds sold?',
      'Who do you sell eggs to?',
      'Whom do you sell chicken to?'
    ],

    'Chicken (Egg Incubation)': [
      'What is the Initial cost of investment?',
      'How many incubators do you have?',
      'What is the capacity of the incubator?',
      'What is the number of eggs incubated?',
      'What is the number of spoilt eggs?',
      'What is the number of chicks hatched?',
      'What is the number of dead chicks?',
      'What is the number of chicks sold?',
      'What is the average price per chick sold?',
      'What is the income from the chicks sold?'
    ],

    'Dairy': [
      'How many cows do you have?',
      'What is the number of cows in production?',
      'How many liter do the cow(s) produce (total)?',
      'How many liters are consumed at home (total for the reporting period?',
      'What is the average price of 1 liter of milk sold?',
      'How many liters of milk were Sold?',
      'What is the number of calves?',
      'What is the number of calves sold?',
      'What is the average price per calf sold?',
      'What is the income from calves sold?'
    ],

    'Dairy Goat': [
      'How many does do you have?',
      'What is the number of does in milk production?',
      'How many liters of milk does the doe(s) produce in total?',
      'How many liters are consumed at home for the reporting period',
      'What is the average price of 1 liter of milk sold?',
      'How many liters of milk were Sold?',
      'What is the number of kids kidded? (Factor in those that give birth twins, triplets)',
      'What is the number of kids sold?',
      'What is the average price per kid sold?',
      'What is the income from kids sold?'
    ],

    'Apiculture': [
      'What type and no. of hive per do you have?',
      'How many hives have been colonized?',
      'Have you harvested honey during the reporting period?',
      'How many Kgs of crude honey?',
      'How many Kgs of refined honey?',
      'How many Kgs have you sold during the reporting period?',
      'How much did you sell a Kg at?',
      'What is the income gained from sale of honey?',
      'Is there any other hive product you sell apart from honey?',
      'What is the income generated from the same?'
    ],

    'Pigs': [
      'How many pigs do you have excluding piglets?',
      'How many sows do you have?',
      'How many sows are in production?',
      'How many piglets do you have?',
      'How many piglets have you sold during the reporting period?',
      'How much did you sell per piglet?',
      'How many mature pigs have you sold during the reporting period?',
      'Whom did you sell the mature pigs to?',
      'What’s the income gained from the sale of both mature pigs and piglets?',
      'How many pigs have you slaughtered for meat?',
      'What’s the income from sale of meat?',
      'Where did you sell meat or to whom?'
    ],

    'Fish': [
      'How many ponds do you have?',
      'What’s the capacity of each pond?',
      'What fish species are you currently rearing?',
      'What was the initial stocking of fingerlings?',
      'How many kgs have you harvested during the reporting period?',
      'What feed do you use?',
      'Where do you source your feeds?',
      'How much have you spent on feeds during the reporting period?',
      'How much did you sell the fish per Kg?',
      'How many pieces have you sold during the reporting period (for ornamental fish)',
      'Do you have an organized market structure?',
      'Whats the income from sale of fish during the reporting period?',
      'Are you a breeder?',
      'If yes are you licensed?',
      'What is the selling cost of your fingerlings?',
      'How many have you sold during the reporting period?',
      'What’s the income from the sale of fingerlings?'
    ],

  };

  Map<String, TextEditingController> textControllers = {};

  List<Widget> buildQuestionFields() {
    List<String> questions = questionMap[selectedValueChain]!;
    List<Widget> questionFields = [];

    for (String question in questions) {
      if (!textControllers.containsKey(question)) {
        textControllers[question] = TextEditingController();
      }

      if (selectedValueChain == 'Banana' &&
          (question == 'Question 4' || question == 'Question 5')) {
        List<String> options;
        if (question == 'Question 4') {
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
                        print('$question: $answer');
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
}
