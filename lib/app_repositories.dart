import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_provider.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_provider.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';


class AppRepositories extends StatelessWidget {
  final Widget appBlocs;
  final FlutterSecureStorage storage;
  const AppRepositories(
      {Key? key, required this.appBlocs, required this.storage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
        create: (context) => CurrencyListRepository(
          provider: CurrencyListProvider(),
        ),
      ),
      RepositoryProvider(
        create: (context) => ExchangeRatesRepository(
          provider: ExchangeRatesProvider(),
        ),
      ),
    ], child: appBlocs);
  }
}
