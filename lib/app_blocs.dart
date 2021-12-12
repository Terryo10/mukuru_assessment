import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';

import 'bloc/exchange_rates_bloc/exchangerates_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;

  const AppBlocs({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExchangeRatesBloc(
            exchangeRatesRepository:
                RepositoryProvider.of<ExchangeRatesRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => CurrencylistBloc(
            currencyListRepository:
                RepositoryProvider.of<CurrencyListRepository>(context),
            exchangeRatesBloc: BlocProvider.of<ExchangeRatesBloc>(context),
          )..add(GetCurrencies()),
        ),
      ],
      child: app,
    );
  }
}
