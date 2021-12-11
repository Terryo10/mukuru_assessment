part of 'currencylist_bloc.dart';

@immutable
abstract class CurrencylistEvent extends Equatable {}

class GetCurrencies extends CurrencylistEvent {
  @override
  
  List<Object?> get props => [];
}

class AddCurrencyToUserList extends CurrencylistEvent {
 
  final CurrencyRefinedModel currencyRefinedModel;

  AddCurrencyToUserList({required this.currencyRefinedModel});

  @override
  
  List<Object?> get props => [];
}

class RemoveCurrencyFromUserList extends CurrencylistEvent {
 
  final CurrencyMonitor currencyMonitor;

  RemoveCurrencyFromUserList({required this.currencyMonitor});

  @override
  
  List<Object?> get props => [];
}

class AutoUpdateCurrencyFromUserList extends CurrencylistEvent {
 
  final AutoUpdateCurrencyFromUserList currencyRefinedModel;

  AutoUpdateCurrencyFromUserList({required this.currencyRefinedModel});

  @override
  
  List<Object?> get props => [];
}