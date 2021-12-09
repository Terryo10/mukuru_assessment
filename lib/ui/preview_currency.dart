import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';

import 'extras/currency_preview_error.dart';

class PreviewCurrency extends StatefulWidget {
  const PreviewCurrency({
    Key? key,
  }) : super(key: key);

  @override
  _PreviewCurrencyState createState() => _PreviewCurrencyState();
}

class _PreviewCurrencyState extends State<PreviewCurrency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange'),
        backgroundColor: Colors.amber[800],
      ),
      body: BlocListener<ExchangeRatesBloc, ExchangeRatesState>(
        listener: (context, state) {
          if (state is ExchangeRatesLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Currency Loaded  ')));
          }
        },
        child: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
          builder: (context, state) {
            if (state is ExchangeRatesLoadingState) {
              return loading();
            } else if (state is ExchangeRatesLoadedState) {
              return Column(
                children: [
                  Container(
                    height: 30.0,
                    color: Colors.orange[100],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${state.selectedCurrency.name} (${state.selectedCurrency.abr})',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: currencyCalculator(
                        exchangeRatesModel: state.exchangeRatesModel,
                        selectedCurrency: state.selectedCurrency),
                  ),
                ],
              );
            }
            if (state is ExchangeRatesErrorState) {
              return CurrencyPreviewError(
                message: state.message,
              );
            }
            return const CurrencyPreviewError(
              message: 'Oops Something Happened',
            );
          },
        ),
      ),
    );
  }

  Widget currencyCalculator(
      {required ExchangeRatesModel exchangeRatesModel,
      required CurrencyRefinedModel selectedCurrency}) {
    return Center(
      child: Text(exchangeRatesModel.license.toString()),
    );
  }

  Widget loading() {
    return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: const <Widget>[
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        backgroundColor: Color(0xfff7892b),
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    'Loading ...',
                    style: TextStyle(color: Colors.black),
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
