import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const CalculatorHome(title: 'CALCULATOR'),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key, required this.title});

  final String title;

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  TextEditingController _controller = TextEditingController();
  String result = '0';
  String operation = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String btnText) {
    setState(() {
      if (btnText == 'AC') {
        _controller.clear();
        result = '0';
        num1 = 0;
        num2 = 0;
        operation = '';
      } else if (btnText == '⌫') {
        String text = _controller.text;
        if (text.isNotEmpty) {
          _controller.text = text.substring(0, text.length - 1);
        }
        if (_controller.text.isEmpty) {
          _controller.text = '0';
        }
      } else if (btnText == '%' || btnText == '/' || btnText == 'x' || btnText == '-' || btnText == '+') {
        num1 = double.parse(_controller.text);
        operation = btnText;
        _controller.clear();
      } else if (btnText == '=') {
        num2 = double.parse(_controller.text);
        switch (operation) {
          case '+':
            result = (num1 + num2).toString();
            break;
          case '-':
            result = (num1 - num2).toString();
            break;
          case 'x':
            result = (num1 * num2).toString();
            break;
          case '/':
            if (num2 != 0) {
              result = (num1 / num2).toString();
            } else {
              result = 'Error';
            }
            break;
          case '%':
            result = (num1 % num2).toString();
            break;
          default:
            result = _controller.text;
            break;
        }
        _controller.text = result;
        num1 = 0;
        num2 = 0;
        operation = '';
      } else {
        if (_controller.text == '0') {
          _controller.text = btnText;
        } else {
          _controller.text += btnText;
        }
      }
    });
  }

  Widget calButton(String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPressed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          btnText,
          style: TextStyle(color: txtColor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(
          'CALCULATOR',
          style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.normal),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            height: 100,
            width: double.infinity,
            color: Colors.grey[900],
            child: TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white, fontSize: 60),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '0',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
              keyboardType: TextInputType.number,
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButton('AC', Colors.white, 80, Colors.brown[400]!),
                    calButton('⌫', Colors.white, 80, Colors.orange[200]!),
                    calButton('%', Colors.white, 80, Colors.blueGrey[300]!),
                    calButton('/', Colors.white, 80, Colors.blue[200]!),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButton('7', Colors.white, 80, Colors.purple[200]!),
                    calButton('8', Colors.white, 80, Colors.purple[200]!),
                    calButton('9', Colors.white, 80, Colors.purple[200]!),
                    calButton('x', Colors.white, 80, Colors.blue[200]!),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButton('4', Colors.white, 80, Colors.purple[200]!),
                    calButton('5', Colors.white, 80, Colors.purple[200]!),
                    calButton('6', Colors.white, 80, Colors.purple[200]!),
                    calButton('-', Colors.white, 80, Colors.blue[200]!),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButton('1', Colors.white, 80, Colors.purple[200]!),
                    calButton('2', Colors.white, 80, Colors.purple[200]!),
                    calButton('3', Colors.white, 80, Colors.purple[200]!),
                    calButton('+', Colors.white, 80, Colors.blue[200]!),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButton('0', Colors.white, 170, Colors.purple[200]!),
                    calButton('.', Colors.white, 80, Colors.purple[200]!),
                    calButton('=', Colors.white, 80, Colors.pink[400]!),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
