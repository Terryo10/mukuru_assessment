part of 'currencylist_bloc.dart';

@immutable
abstract class CurrencylistEvent {}

class GetCurrencies extends CurrencylistEvent {}

class AddCurrencyToUserList {
  final CurrencyRefinedModel currencyRefinedModel;

  AddCurrencyToUserList(this.currencyRefinedModel);
}
