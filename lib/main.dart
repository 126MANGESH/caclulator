import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size; 
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  void onButtonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            InkWell(
              onTap: () {},
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/passport photo.JPG'),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () {},
              child: const Text(
                'Calculator',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(11),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      output,
                      style: TextStyle(fontSize: outputSize, color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 55, 
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      button(text: 'AC', buttonBgColor: Colors.orange, tColor: Colors.black),
                      button(text: '<', buttonBgColor: Colors.orange, tColor: Colors.black),
                      button(text: '%', buttonBgColor: Colors.orange, tColor: Colors.black),
                      button(text: '/', buttonBgColor: Colors.orange, tColor: Colors.black),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '*', buttonBgColor: Colors.orange, tColor: Colors.black),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-', buttonBgColor: Colors.orange, tColor: Colors.black),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+', buttonBgColor: Colors.orange, tColor: Colors.black),
            ],
          ),
          Row(
            children: [
              button(text: '~', buttonBgColor: Colors.orange, tColor: Colors.black),
              button(text: '0'),
              button(text: '.'),
              button(text: '=', buttonBgColor: Colors.orange, tColor: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({
    required text,
    tColor = Colors.white,
    buttonBgColor = Colors.black,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(11),
          ),
          onPressed: () {
            onButtonClick(text);
          },
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
