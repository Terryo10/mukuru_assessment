part of 'currencylist_bloc.dart';

@immutable
abstract class CurrencylistState {}

class CurrencylistInitialState extends CurrencylistState {}

class CurrencylistLoadingState extends CurrencylistState {}

class CurrencylistLoadedState extends CurrencylistState {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  final List myCurrencies;

  CurrencylistLoadedState({required this.myCurrencies, required this.data});

  CurrencylistLoadedState copyWith({data, myCurrencies}) {
    return CurrencylistLoadedState(
      myCurrencies: myCurrencies ?? this.myCurrencies,
      data: data ?? this.data
    );
  }
}

class CurrencylistErrorState extends CurrencylistState {
  final String message;

  CurrencylistErrorState({required this.message});
}
