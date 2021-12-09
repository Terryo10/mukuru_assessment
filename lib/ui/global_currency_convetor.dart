import 'package:flutter/material.dart';

class GlobalCurrencyConvetor extends StatefulWidget {
  const GlobalCurrencyConvetor({Key? key}) : super(key: key);

  @override
  _GlobalCurrencyConvetorState createState() => _GlobalCurrencyConvetorState();
}

class _GlobalCurrencyConvetorState extends State<GlobalCurrencyConvetor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.amber[800],
      ),
      body: Container(),
    );
  }
}
