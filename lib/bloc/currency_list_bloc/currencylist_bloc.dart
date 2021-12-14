import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      var selectedCurrency =
          currencyRefinedModelFromJson(event.currencyMonitor.monitoredCurrency);
      exchangeRatesBloc.add(
        GetExchangeRates(
          selectedCurrency: CurrencyRefinedModel(
              abr: selectedCurrency.abr,
              name: selectedCurrency.name,
              warningRate: selectedCurrency.warningRate),
        ),
      );

      var currentTime = DateTime.now();
      var oldCurrencyMonitor = event.currencyMonitor;
      List oldList = jsonDecode(oldCurrencyMonitor.updates);
      var currentExchangeState = exchangeRatesBloc.state;
      if (currentExchangeState is ExchangeRatesLoadedState) {
        var selectedRate = currentExchangeState
            .exchangeRatesModel.rates![selectedCurrency.abr];
        oldList.add(
          WatchedLogsModel(
            checkedAt: currentTime,
            minimumRate: event.minimumRate,
            //new rate from server
            rate: selectedRate!.toDouble(),
          ),
        );
      }

      var newList = jsonEncode(oldList);

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

    if (event is AutoUpdateAllCurrenciesList) {
      print('automated checking trriggered');
      //get all monitored currencies in app
      var currentTime = DateTime.now();

      List<CurrencyMonitor> currencyList =
          await DatabaseHelper.instance.getMonitoredCurrencies();

      if (currencyList.isNotEmpty) {
        for (var element in currencyList) {
          var oldCurrencyMonitor =
              currencyRefinedModelFromJson(element.monitoredCurrency);
          List oldList = jsonDecode(element.updates);

          var currentExchangeState = exchangeRatesBloc.state;
          if (currentExchangeState is ExchangeRatesLoadedState) {
            var selectedRate = currentExchangeState
                .exchangeRatesModel.rates![oldCurrencyMonitor.abr];
            oldList.add(
              WatchedLogsModel(
                checkedAt: currentTime,
                minimumRate: oldCurrencyMonitor.warningRate,
                rate: selectedRate!.toDouble(),
              ),
            );
            var newList = jsonEncode(oldList);
            await DatabaseHelper.instance.updateCurrency(
                currencyMonitor: CurrencyMonitor(
                    id: element.id,
                    monitoredCurrency: element.monitoredCurrency,
                    rate: element.rate,
                    updates: newList));
            if (currentState is CurrencylistLoadedState) {
              var currentList =
                  await DatabaseHelper.instance.getMonitoredCurrencies();

              yield currentState.copyWith(myCurrencies: currentList);
            }
          }
        }
      }
    }
  }
}
