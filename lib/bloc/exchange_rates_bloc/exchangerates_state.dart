part of 'exchangerates_bloc.dart';

@immutable
abstract class ExchangeRatesState {}

class ExchangeratesInitialState extends ExchangeRatesState {}

class ExchangeRatesLoadingState extends ExchangeRatesState {
  final ExchangeRatesModel exchangeRatesModel;

  ExchangeRatesLoadingState({required this.exchangeRatesModel});
}

class ExchangeRatesLoadedState extends ExchangeRatesState {}

class ExchangeRatesErrorState extends ExchangeRatesState {
  final String message;

  ExchangeRatesErrorState({required this.message});
}
