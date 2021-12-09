import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';

part 'exchangerates_event.dart';
part 'exchangerates_state.dart';

class ExchangeRatesBloc extends Bloc<ExchangeRatesEvent, ExchangeRatesState> {
  final ExchangeRatesRepository exchangeRatesRepository;
  ExchangeRatesBloc({
    required this.exchangeRatesRepository,
  }) : super(ExchangeratesInitialState());

  @override
  Stream<ExchangeRatesState> mapEventToState(
    ExchangeRatesEvent event,
  ) async* {
    var currentState = state;
    if (currentState is ExchangeRatesLoadedState) {
      if (event is GetExchangeRates) {}
    } else {
      if (event is GetExchangeRates) {
        yield ExchangeRatesLoadingState();
      }
    }
  }
}
