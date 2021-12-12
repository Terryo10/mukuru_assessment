import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:intl/intl.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';

class ConversionPage extends StatefulWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final amountController = TextEditingController();
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'USD');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Convetor'),
        backgroundColor: Colors.amber[800],
      ),
      body: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
        builder: (context, state) {
          if (state is ExchangeRatesLoadedState) {
            return convetor(
                exchangeRatesModel: state.exchangeRatesModel,
                selectedCurrency: state.selectedCurrency);
          }
          return Container();
        },
      ),
    );
  }

  Widget convetor(
      {required ExchangeRatesModel exchangeRatesModel,
      required CurrencyRefinedModel selectedCurrency}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _amountField(
              'Enter amount you wish to convert for ${selectedCurrency.abr} currency to USD'),
          _textConvertor(context,
              exchangeRatesModel: exchangeRatesModel,
              selectedCurrency: selectedCurrency)
        ],
      ),
    );
  }

  _textConvertor(BuildContext context,
      {required ExchangeRatesModel exchangeRatesModel,
      required CurrencyRefinedModel selectedCurrency}) {
    var selectedRate = exchangeRatesModel.rates![selectedCurrency.abr];
    var value = 0;

    if (amountController.text.isNotEmpty) {
      value = int.parse(amountController.text);
    }

    var ratedValue = (value / selectedRate!);
    var format = formatCurrency.format(ratedValue);
    return Text('USD ' + format.toString(),
        style: const TextStyle(fontSize: 18));
  }

  Widget _amountField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {});
            },
            maxLength: 15,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            controller: amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            obscureText: isPassword,
            decoration: const InputDecoration(
                hintText: 'eg 5000',
                fillColor: Color(0xfff7892b),
                filled: true),
          )
        ],
      ),
    );
  }
}
