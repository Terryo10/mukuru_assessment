import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mukuru_app/database/monitored_currencies_database.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';

part 'currencylist_event.dart';
part 'currencylist_state.dart';

class CurrencylistBloc extends Bloc<CurrencylistEvent, CurrencylistState> {
  final CurrencyListRepository currencyListRepository;

  CurrencylistBloc({
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
              updates: '[]'),
        );
        var currentList =
            await DatabaseHelper.instance.getMonitoredCurrencies();

        // currentList.add(event.currencyRefinedModel);
        yield currentState.copyWith(myCurrencies: currentList);
      }
    }

    if (event is RemoveCurrencyFromUserList) {
      if (currentState is CurrencylistLoadedState) {
        var currentList =
            await DatabaseHelper.instance.removeCurrency();
        // currentList.remove(event.currencyRefinedModel);

        yield currentState.copyWith(myCurrencies: currentList);
      }
    }
  }
}
