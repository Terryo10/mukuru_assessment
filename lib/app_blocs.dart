import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';

import 'bloc/exchange_rates_bloc/exchangerates_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget app;
  final FlutterSecureStorage storage;
  const AppBlocs({Key? key, required this.app, required this.storage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CurrencylistBloc(
            currencyListRepository:
                RepositoryProvider.of<CurrencyListRepository>(context),
          )..add(GetCurrencies()),
        ),
        BlocProvider(
          create: (context) => ExchangeRatesBloc(
            exchangeRatesRepository:
                RepositoryProvider.of<ExchangeRatesRepository>(context),
          )..add(GetExchangeRates()),
        ),
      ],
      child: app,
    );
  }
}
