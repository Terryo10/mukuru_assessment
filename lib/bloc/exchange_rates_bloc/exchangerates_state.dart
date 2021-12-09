part of 'exchangerates_bloc.dart';

@immutable
abstract class ExchangeRatesState {}

class ExchangeratesInitialState extends ExchangeRatesState {}

class ExchangeRatesLoadingState extends ExchangeRatesState {}

class ExchangeRatesLoadedState extends ExchangeRatesState {
  final ExchangeRatesModel exchangeRatesModel;
  final CurrencyRefinedModel selectedCurrency;

  ExchangeRatesLoadedState(
      {required this.selectedCurrency, required this.exchangeRatesModel});

  ExchangeRatesLoadedState copyWith({exchangeRatesModel, selectedCurrency}) =>
      ExchangeRatesLoadedState(
          exchangeRatesModel: exchangeRatesModel ?? this.exchangeRatesModel,
          selectedCurrency: selectedCurrency?? this.selectedCurrency);
}

class ExchangeRatesErrorState extends ExchangeRatesState {
  final String message;

  ExchangeRatesErrorState({required this.message});
}
