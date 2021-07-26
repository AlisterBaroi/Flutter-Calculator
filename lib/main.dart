import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alister Calc',
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
// Calculation Logics
  String equation = "0";
  String expression = "";

  btnClicked(text) {
    setState(() {
      HapticFeedback.heavyImpact();
      if (text == "AC") {
        equation = "0";
      } else if (text == "back") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (text == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '(*100)');
        try {
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          expression = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = expression;
        } catch (e) {
          equation = "Error";
        }
      } else if (equation == "0") {
        equation = text;
      } else {
        equation = equation + text;
      }
    });
  }

// Calculator buttons (except back button)
  Widget calcButon1(String text, Color col1, Color col2) {
    return RaisedButton(
      onPressed: () => btnClicked(text),
      color: col1,
      padding: EdgeInsets.all(15),
      shape: CircleBorder(side: BorderSide(color: bgColor2)),
      child: Text(
        '$text',
        style: TextStyle(fontSize: 40, color: col2),
      ),
    );
  }

  // Back button, has icons inside
  Widget calcButon2(String text, Color col1, Color col2) {
    text;
    return RaisedButton(
      onPressed: () => btnClicked(text),
      color: col1,
      padding: EdgeInsets.all(17),
      shape: CircleBorder(side: BorderSide(color: bgColor2)),
      child: Icon(
        Icons.backspace_outlined,
        size: 45,
        color: col2,
      ),
    );
  }

  // Eqials button, has double width (unused)
  // Widget calcButon3(String text, Color col1, Color col2) {
  //   return ButtonTheme(
  //     minWidth: 200,
  //     child: RaisedButton(
  //       onPressed: () => btnClicked(text),
  //       color: col1,
  //       padding: EdgeInsets.all(15),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //       child: Text(
  //         '$text',
  //         style: TextStyle(fontSize: 40, color: col2),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alister Calc'),
          backgroundColor: bgColor,
          shadowColor: null,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: bgColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 130,
                ),
                Text(
                  "$equation",
                  style: TextStyle(fontSize: 75, color: Color1),
                ),
                SizedBox(
                  height: 20,
                ),
                new Container(
                  height: 3,
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: bgColor2,
                        blurRadius: 0.0,
                        spreadRadius: 0,
                        offset: Offset(
                          0,
                          -15.0,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButon1('AC', bgColor2, Color2),
                      calcButon2("back", bgColor2, Color2),
                      calcButon1('%', bgColor2, Color3),
                      calcButon1('÷', bgColor2, Color3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // calcButon5('7', Color1, Color1),
                      calcButon1('7', Color2, Color1),
                      calcButon1('8', Color2, Color1),
                      calcButon1('9', Color2, Color1),
                      calcButon1('×', bgColor2, Color3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButon1('4', Color2, Color1),
                      calcButon1('5', Color2, Color1),
                      calcButon1('6', Color2, Color1),
                      calcButon1('-', bgColor2, Color3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      calcButon1('1', Color2, Color1),
                      calcButon1('2', Color2, Color1),
                      calcButon1('3', Color2, Color1),
                      calcButon1('+', bgColor2, Color3),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // calcButon1('00', Color2, Color1),
                      calcButon1('0', Color2, Color1),
                      calcButon1('00', Color2, Color1),
                      calcButon1('.', Color2, Color1),
                      calcButon1('=', bgColor2, Color3),

                      // double width 0/= (unused)
                      // Container(
                      //   alignment: AlignmentDirectional.center,
                      //   margin: const EdgeInsets.symmetric(horizontal: 5),
                      //   width: 170,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(50)),
                      //   child: calcButon3('0', Color2, Color1),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
