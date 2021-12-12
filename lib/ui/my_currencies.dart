import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/database/monitored_currencies_database.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/ui/preview_currency.dart';

import 'extras/error_build.dart';

class MyCurrencies extends StatefulWidget {
  const MyCurrencies({Key? key}) : super(key: key);

  @override
  _MyCurrenciesState createState() => _MyCurrenciesState();
}

class _MyCurrenciesState extends State<MyCurrencies> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrencylistBloc, CurrencylistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<CurrencylistBloc, CurrencylistState>(
        builder: (context, state) {
          if (state is CurrencylistLoadedState) {
            return myCurrencies(data: state.myCurrencies);
          }
          return const ErrorBuild(
            message: 'Oops something happened',
          );
        },
      ),
    );
  }

  Widget myCurrencies({required List<CurrencyMonitor> data}) {
    if (data.isEmpty) {
      return const Center(
        child: Text('You have no monitored currencies'),
      );
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          print(data[index].monitoredCurrency);
          // var mappedString = json.encode(data[index].monitoredCurrency);
          return currencyCard(
              data: currencyRefinedModelFromJson(data[index].monitoredCurrency),
              state: CurrencyMonitor(
                  id: data[index].id,
                  monitoredCurrency: data[index].monitoredCurrency,
                  rate: data[index].rate,
                  updates: data[index].updates));
        });
  }

  Widget currencyCard(
      {required CurrencyRefinedModel data, required CurrencyMonitor state}) {
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewCurrency(
                      id: int.parse(state.id.toString()),
                    )),
          );
          BlocProvider.of<ExchangeRatesBloc>(context)
              .add(GetExchangeRates(selectedCurrency: data));
        },
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
                      onTap: () {
                        BlocProvider.of<CurrencylistBloc>(context).add(
                            RemoveCurrencyFromUserList(currencyMonitor: state));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Currency Removed ')));
                      },
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
}
