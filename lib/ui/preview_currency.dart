import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
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
          // TODO: implement listener
        },
        child: BlocBuilder<ExchangeRatesBloc, ExchangeRatesState>(
          builder: (context, state) {
            if (state is ExchangeRatesLoadingState) {
              return loading();
            } else if (state is ExchangeRatesLoadedState) {
              return Container();
            }
            return const CurrencyPreviewError(
              message: 'Oops Something Happened',
            );
          },
        ),
      ),
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
