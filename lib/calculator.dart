import 'package:calculator/colorss.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calcuz extends StatefulWidget {
  const Calcuz({Key? key}) : super(key: key);

  @override
  State<Calcuz> createState() => _CalcuzState();
}

class _CalcuzState extends State<Calcuz> {
  ///variables
  double fnum = 0.0;
  double secnum = 0.0;
  var input = '';
  var output = '';
  var operator = '';
  var hideInput= false;
  var outputSize=34.0;

  onButtonClick(value) {
    // print(value);
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
        userInput = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if(output.endsWith('.0')){
          output=output.substring(0,output.length -2);
        }
        input=output;
        hideInput=true;
        outputSize=55;
      }
    } else {
      input = input + value;
      hideInput=false;
      outputSize=34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ///  input/output area
            Expanded(
              child: Container(
                  width: double.infinity,
                  color: Colors.white12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hideInput ?  '' : input,
                        style: const TextStyle(fontSize: 45, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        style: const TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            ),

            ///buttons
            Row(
              children: [
                CalButton(
                    numb: 'AC',
                    textColor: Colors.deepOrange,
                    buttonBgColor: operatorColor),
                CalButton(
                    numb: '<',
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),
                CalButton(numb: '', buttonBgColor: Colors.transparent),
                CalButton(
                    numb: '/',
                    textColor: orangeColor,
                    buttonBgColor: operatorColor),],),
            Row(
              children: [
                CalButton(numb: '7'),
                CalButton(numb: '8'),
                CalButton(numb: '9'),
                CalButton(
                    numb: 'x',
                    textColor: Colors.orangeAccent,
                    buttonBgColor: operatorColor),],),
            Row(
              children: [
                CalButton(numb: '4'),
                CalButton(numb: '5'),
                CalButton(numb: '6'),
                CalButton(
                    numb: '-',
                    textColor: Colors.orangeAccent,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                CalButton(numb: '1'),
                CalButton(numb: '2'),
                CalButton(numb: '3'),
                CalButton(
                    numb: '+',
                    textColor: Colors.orangeAccent,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                CalButton(numb: '%'),
                CalButton(numb: '0'),
                CalButton(numb: '.'),
                CalButton(
                    numb: '=',
                    textColor: Colors.orangeAccent,
                    buttonBgColor: orangeColor),
              ],
            ),
          ],
        ));
  }



  Widget CalButton(
      {numb, textColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
        child: Container(
          margin: const EdgeInsets.all(14),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(20),
                backgroundColor: buttonColor),
            onPressed: () => onButtonClick(numb),
            child: Text(
              numb,
              style: TextStyle(color: Colors.white, fontSize: 21),
            ),
          ),
        ));
  }
}
