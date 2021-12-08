part of 'currencylist_bloc.dart';

@immutable
abstract class CurrencylistEvent {}

class GetCurrencies extends CurrencylistEvent {}

class AddCurrencyToUserList extends CurrencylistEvent {
 
  final CurrencyRefinedModel currencyRefinedModel;

  AddCurrencyToUserList(
      {
      required this.currencyRefinedModel});
}
