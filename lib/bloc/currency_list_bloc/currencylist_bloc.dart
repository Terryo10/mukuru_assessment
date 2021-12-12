import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/database/monitored_currencies_database.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/models/watched_logs_model.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';

part 'currencylist_event.dart';
part 'currencylist_state.dart';

class CurrencylistBloc extends Bloc<CurrencylistEvent, CurrencylistState> {
  final CurrencyListRepository currencyListRepository;
  final ExchangeRatesBloc exchangeRatesBloc;

  CurrencylistBloc({
    required this.exchangeRatesBloc,
    required this.currencyListRepository,
  }) : super(CurrencylistInitialState());

  @override
  Stream<CurrencylistState> mapEventToState(
    CurrencylistEvent event,
  ) async* {
    var currentState = state;
    //action comes here lol
    if (event is GetCurrencies) {
      yield CurrencylistLoadingState();
      try {
        var currencyList =
            await DatabaseHelper.instance.getMonitoredCurrencies();
        var data = await currencyListRepository.getCurrencyList();
        yield CurrencylistLoadedState(data: data, myCurrencies: currencyList);
      } catch (e) {
        yield CurrencylistErrorState(message: e.toString());
      }
    }

    if (event is AddCurrencyToUserList) {
      if (currentState is CurrencylistLoadedState) {
        await DatabaseHelper.instance.addCurrency(
          currencyMonitor: CurrencyMonitor(
              monitoredCurrency:
                  json.encode(event.currencyRefinedModel.toJson()),
              rate: event.currencyRefinedModel.warningRate.toString(),
              updates: json.encode([])),
        );
        var currentList =
            await DatabaseHelper.instance.getMonitoredCurrencies();

        // currentList.add(event.currencyRefinedModel);
        yield currentState.copyWith(myCurrencies: currentList);
      }
    }

    if (event is RemoveCurrencyFromUserList) {
      if (currentState is CurrencylistLoadedState) {
        await DatabaseHelper.instance
            .removeCurrency(id: int.parse(event.currencyMonitor.id.toString()));
        var currentList =
            await DatabaseHelper.instance.getMonitoredCurrencies();

        yield currentState.copyWith(myCurrencies: currentList);
      }
    }

    if (event is AutoUpdateCurrencyFromUserList) {
      var currentTime = DateTime.now();
      var oldCurrencyMonitor = event.currencyMonitor;
      List oldList = jsonDecode(oldCurrencyMonitor.updates);
      oldList.add(WatchedLogsModel(
          checkedAt: currentTime,
          minimumRate: event.minimumRate,
          //new rate from server
          rate: double.parse(oldCurrencyMonitor.rate)));
      var newList = jsonEncode(oldList);
      print(event.currencyMonitor.id);
      await DatabaseHelper.instance.updateCurrency(
          currencyMonitor: CurrencyMonitor(
              id: event.currencyMonitor.id,
              monitoredCurrency: event.currencyMonitor.monitoredCurrency,
              rate: event.currencyMonitor.rate,
              updates: newList));
      if (currentState is CurrencylistLoadedState) {
        var currentList =
            await DatabaseHelper.instance.getMonitoredCurrencies();

        yield currentState.copyWith(myCurrencies: currentList);
      }
    }
  }
}
