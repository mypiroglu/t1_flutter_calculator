import 'dart:math';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _expression = '';

  static const Color operatorColor = Color(0xFFFF9500);
  static const Color functionColor = Color(0xFFA5A5A5);
  static const Color numberColor = Color(0xFF333333);

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  double _evaluate(String exp) {
    exp = exp.replaceAll('×', '*').replaceAll('÷', '/');
    final tokens = <String>[];
    var number = '';
    for (var i = 0; i < exp.length; i++) {
      final ch = exp[i];
      if ('0123456789.'.contains(ch) ||
          (ch == '-' && (i == 0 || '+-*/'.contains(exp[i - 1])))) {
        number += ch;
      } else if ('+-*/'.contains(ch)) {
        if (number.isNotEmpty) {
          tokens.add(number);
          number = '';
        }
        tokens.add(ch);
      }
    }
    if (number.isNotEmpty) tokens.add(number);

    final values = <double>[];
    final ops = <String>[];

    int prec(String op) => (op == '+' || op == '-') ? 1 : 2;

    void apply() {
      final b = values.removeLast();
      final a = values.removeLast();
      final op = ops.removeLast();
      switch (op) {
        case '+':
          values.add(a + b);
          break;
        case '-':
          values.add(a - b);
          break;
        case '*':
          values.add(a * b);
          break;
        case '/':
          values.add(a / b);
          break;
      }
    }

    for (final token in tokens) {
      if ('+-*/'.contains(token)) {
        while (ops.isNotEmpty && prec(ops.last) >= prec(token)) {
          apply();
        }
        ops.add(token);
      } else {
        values.add(double.parse(token));
      }
    }
    while (ops.isNotEmpty) {
      apply();
    }
    return values.isEmpty ? 0 : values.single;
  }

  void _calculate() {
    setState(() {
      if (_expression.isEmpty) return;
      final result = _evaluate(_expression);
      _expression = result.toString().replaceAll(RegExp(r'\.0+\$'), '');
    });
  }

  void _clear() {
    setState(() {
      _expression = '';
    });
  }

  void _toggleSign() {
    if (_expression.isEmpty) return;
    setState(() {
      var idx = _expression.length - 1;
      while (idx >= 0 && !'+-×÷'.contains(_expression[idx])) {
        idx--;
      }
      final start = idx + 1;
      var number = _expression.substring(start);
      if (number.startsWith('-')) {
        number = number.substring(1);
      } else {
        number = '-$number';
      }
      _expression = _expression.substring(0, start) + number;
    });
  }

  void _percent() {
    if (_expression.isEmpty) return;
    setState(() {
      var idx = _expression.length - 1;
      while (idx >= 0 && !'+-×÷'.contains(_expression[idx])) {
        idx--;
      }
      final start = idx + 1;
      final number = _expression.substring(start);
      final value = double.tryParse(number) ?? 0;
      _expression =
          _expression.substring(0, start) + (value / 100).toString();
    });
  }

  Widget _buildButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: text == '0'
            ? MediaQuery.of(context).size.width / 2
            : MediaQuery.of(context).size.width / 4,
        height: MediaQuery.of(context).size.width / 4,
        color: color,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.bottomRight,
            child: Text(
              _expression,
              style: const TextStyle(fontSize: 60, color: Colors.white),
            ),
          ),
          Row(
            children: [
              _buildButton('C', functionColor, _clear),
              _buildButton('±', functionColor, _toggleSign),
              _buildButton('%', functionColor, _percent),
              _buildButton('÷', operatorColor, () => _addToExpression('÷')),
            ],
          ),
          Row(
            children: [
              _buildButton('7', numberColor, () => _addToExpression('7')),
              _buildButton('8', numberColor, () => _addToExpression('8')),
              _buildButton('9', numberColor, () => _addToExpression('9')),
              _buildButton('×', operatorColor, () => _addToExpression('×')),
            ],
          ),
          Row(
            children: [
              _buildButton('4', numberColor, () => _addToExpression('4')),
              _buildButton('5', numberColor, () => _addToExpression('5')),
              _buildButton('6', numberColor, () => _addToExpression('6')),
              _buildButton('-', operatorColor, () => _addToExpression('-')),
            ],
          ),
          Row(
            children: [
              _buildButton('1', numberColor, () => _addToExpression('1')),
              _buildButton('2', numberColor, () => _addToExpression('2')),
              _buildButton('3', numberColor, () => _addToExpression('3')),
              _buildButton('+', operatorColor, () => _addToExpression('+')),
            ],
          ),
          Row(
            children: [
              _buildButton('0', numberColor, () => _addToExpression('0')),
              _buildButton('.', numberColor, () => _addToExpression('.')),
              _buildButton('=', operatorColor, _calculate),
            ],
          ),
        ],
      ),
    );
  }
}
