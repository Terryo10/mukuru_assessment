import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';

part 'currencylist_event.dart';
part 'currencylist_state.dart';

class CurrencylistBloc extends Bloc<CurrencylistEvent, CurrencylistState> {
  final CurrencyListRepository currencyListRepository;
  final FlutterSecureStorage storage;
  CurrencylistBloc({
    required this.storage,
    required this.currencyListRepository,
  }) : super(CurrencylistInitialState());

  @override
  Stream<CurrencylistState> mapEventToState(
    CurrencylistEvent event,
  ) async* {
    //action comes here lol
    if (event is GetCurrencies) {
      yield CurrencylistLoadingState();
      try {
        var currenciesList = await storage.read(key: 'myCurrencyList');

        var decodedCurrencyList = json.decode(currenciesList ?? '[]');

        var data = await currencyListRepository.getCurrencyList();
        yield CurrencylistLoadedState(
            data: data, myCurrencies: decodedCurrencyList);
      } catch (e) {
        yield CurrencylistErrorState(message: e.toString());
      }
    }

    if (event is AddCurrencyToUserList) {
      //copy old state to new state and add currencies

    }
  }
}
