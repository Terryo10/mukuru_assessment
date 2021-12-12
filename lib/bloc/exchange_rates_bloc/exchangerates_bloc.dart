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
      if (event is GetExchangeRates) {
        print('updating currency');
        var data = await exchangeRatesRepository.getExchangeRates();
        yield currentState.copyWith(
            selectedCurrency: event.selectedCurrency, exchangeRatesModel: data);
      }
    } else {
      if (event is GetExchangeRates) {
        try {
          yield ExchangeRatesLoadingState();
          var data = await exchangeRatesRepository.getExchangeRates();
          print('this is' + data.toString());
          yield ExchangeRatesLoadedState(
              selectedCurrency: event.selectedCurrency,
              exchangeRatesModel: data);
        } catch (e) {
          yield ExchangeRatesErrorState(message: e.toString());
        }
      }
    }
  }
}
