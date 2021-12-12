import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/database/monitored_currencies_database.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';

import 'conversion_page.dart';
import 'extras/currency_preview_error.dart';

class PreviewCurrency extends StatefulWidget {
  final int id;
  const PreviewCurrency({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _PreviewCurrencyState createState() => _PreviewCurrencyState();
}

class _PreviewCurrencyState extends State<PreviewCurrency> {
  var pageRate = 0;
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
                        context: context,
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
      required CurrencyRefinedModel selectedCurrency,
      required BuildContext context}) {
    var selectedRate = exchangeRatesModel.rates![selectedCurrency.abr];
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 0),
        child: Column(
          children: <Widget>[
            Text(
                'The current Exchange rate for ${selectedCurrency.abr} aganist USD is $selectedRate '),
            const SizedBox(height: 15),
            Text(
                'Your selected minimum rate is ${selectedCurrency.warningRate}'),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ConversionPage()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(2, 4),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                child: const Text(
                  'Go To Conversion Page',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            BlocBuilder<CurrencylistBloc, CurrencylistState>(
                builder: (context, state) {
              if (state is CurrencylistLoadedState) {
                // get list of transaction from user currency list
                var transactions = state.myCurrencies
                    .firstWhere((element) => element.id == widget.id);

                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(25),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        child: const Text(
                          'refresh',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        onPressed: () {
                          BlocProvider.of<CurrencylistBloc>(context).add(
                              AutoUpdateCurrencyFromUserList(
                                  currencyMonitor: transactions,
                                  minimumRate:
                                      double.parse(transactions.rate)));
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(transactions.updates.toString()),
                  ],
                );
              }
              return const Text('Error Loading Transaction History');
            }),
          ],
        ));
  }

  Widget transactionHistory({required List<CurrencyMonitor> data}) {
    if (data.isEmpty) {
      return const Center(
        child: Text('You have no monitored currencies'),
      );
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          // print(data[index].monitoredCurrency);
          // var mappedString = json.encode(data[index].monitoredCurrency);
          return currencyCard(
            data: currencyRefinedModelFromJson(data[index].monitoredCurrency),
          );
        });
  }

  Widget currencyCard({required CurrencyRefinedModel data}) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20.0,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.5),
            side: const BorderSide(
              width: 0.5,
              color: Color(0xfff7892b),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.name.toString()} (${data.abr})',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: 'CenturyGothicBold',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
            ]),
          ),
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
