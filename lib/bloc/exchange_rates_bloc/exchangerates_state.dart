part of 'exchangerates_bloc.dart';

@immutable
abstract class ExchangeRatesState {}

class ExchangeratesInitialState extends ExchangeRatesState {}

class ExchangeRatesLoadingState extends ExchangeRatesState {

}

class ExchangeRatesLoadedState extends ExchangeRatesState {
    final ExchangeRatesModel exchangeRatesModel;

  ExchangeRatesLoadedState({required this.exchangeRatesModel});
}

class ExchangeRatesErrorState extends ExchangeRatesState {
  final String message;

  ExchangeRatesErrorState({required this.message});
}
