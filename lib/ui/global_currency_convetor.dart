import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';

class GlobalCurrencyConvetor extends StatefulWidget {
  const GlobalCurrencyConvetor({Key? key}) : super(key: key);

  @override
  _GlobalCurrencyConvetorState createState() => _GlobalCurrencyConvetorState();
}

class _GlobalCurrencyConvetorState extends State<GlobalCurrencyConvetor> {
  final amountController = TextEditingController();
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'USD');
  String? dropDownValue;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ExchangeRatesBloc>(context).add(
        GetExchangeRates(selectedCurrency: CurrencyRefinedModel(abr: 'USD')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
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
          BlocBuilder<CurrencylistBloc, CurrencylistState>(
            builder: (context, state) {
              List<String> currencyList = [];
              if (state is CurrencylistLoadedState) {
                state.data!.forEach((k, v) => currencyList.add('$k | $v'));

                return DropdownButton<String>(
                  hint: const Text('Select Currency'),
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      // testCurrency = newValue!;
                      
                      dropDownValue = newValue;
                    });
                    BlocProvider.of<ExchangeRatesBloc>(context).add(
                        GetExchangeRates(
                            selectedCurrency: CurrencyRefinedModel(
                                abr: dropDownValue!.substring(0, 3))));
                  },
                  items: currencyList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              }
              return Container();
            },
          ),
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
