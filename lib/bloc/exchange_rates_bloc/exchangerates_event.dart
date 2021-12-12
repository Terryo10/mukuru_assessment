part of 'exchangerates_bloc.dart';

@immutable
abstract class ExchangeRatesEvent extends Equatable {}

class GetExchangeRates extends ExchangeRatesEvent {
  final CurrencyRefinedModel selectedCurrency;

  GetExchangeRates({required this.selectedCurrency});

  @override
  List<Object?> get props => throw UnimplementedError();
}
