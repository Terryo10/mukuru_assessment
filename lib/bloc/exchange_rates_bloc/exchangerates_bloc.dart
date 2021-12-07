import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    //action comes here lol
  }
}
