import 'package:flutter/material.dart';

class MyCurrencies extends StatefulWidget {
  const MyCurrencies({Key? key}) : super(key: key);

  @override
  _MyCurrenciesState createState() => _MyCurrenciesState();
}

class _MyCurrenciesState extends State<MyCurrencies> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('currency List Screen'),
    );
  }
}
