part of 'exchangerates_bloc.dart';

@immutable
abstract class ExchangeRatesEvent {}

class GetExchangeRates extends ExchangeRatesEvent{}