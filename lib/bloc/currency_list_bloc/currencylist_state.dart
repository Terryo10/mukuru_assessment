part of 'currencylist_bloc.dart';

@immutable
abstract class CurrencylistState {
  
}

class CurrencylistInitialState extends CurrencylistState {}

class CurrencylistLoadingState extends CurrencylistState {}

class CurrencylistLoadedState extends CurrencylistState {
  final dynamic data;
  final List<CurrencyRefinedModel> myCurrencies;

  CurrencylistLoadedState({required this.myCurrencies, this.data});

 
  CurrencylistLoadedState copyWith({data, myCurrencies}) =>
      CurrencylistLoadedState(
          myCurrencies: myCurrencies ?? this.myCurrencies,
          data: data ?? this.data);
}

class CurrencylistErrorState extends CurrencylistState {
  final String message;

  CurrencylistErrorState({required this.message});
}
