import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: calculator(),
  ));
}

class calculator extends StatefulWidget {
  const calculator({Key? key}) : super(key: key);

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  //variable

  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = ' ';
  var output = ' ';
  var operation = ' ';
  var hideInput = false;
  var outputSize = 34.0;

  // get p => null;

  onButtonclick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("×", "*");
        Parser P = Parser();
        Expression expression = P.parse(userInput);
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
        body: Column(
          children: [
            //input output area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                //color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      hideInput ? '' : input,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      output,
                      style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),

            Row(
              children: [
                button(
                    text: "AC",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
                button(
                    text: "<",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
                button(text: " ", buttonBgColor: Colors.transparent),
                button(
                    text: " /",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: " 7", buttonBgColor: Colors.transparent),
                button(text: " 8", buttonBgColor: Colors.transparent),
                button(text: "9", buttonBgColor: Colors.transparent),
                button(
                    text: "×",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(text: "4", buttonBgColor: Colors.transparent),
                button(text: "5", buttonBgColor: Colors.transparent),
                button(text: "6", buttonBgColor: Colors.transparent),
                button(
                    text: "-",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
              ],
            ),

            Row(
              children: [
                button(text: "1", buttonBgColor: Colors.transparent),
                button(text: "2", buttonBgColor: Colors.transparent),
                button(text: "3", buttonBgColor: Colors.transparent),
                button(
                    text: "+",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
              ],
            ),
            Row(
              children: [
                button(
                    text: "%",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
                button(text: "0"),
                button(text: ".", buttonBgColor: Colors.transparent),
                button(
                    text: "=",
                    buttonBgColor: operatorColor,
                    tcolor: orangeColor),
              ],
            ),
          ],
        ));
  }

  Widget button({
    text,
    tcolor = Colors.white,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(22),
            primary: buttonBgColor,
          ),
          onPressed: () => onButtonclick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
