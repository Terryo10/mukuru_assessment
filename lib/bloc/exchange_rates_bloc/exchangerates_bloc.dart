import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exchangerates_event.dart';
part 'exchangerates_state.dart';

class ExchangeratesBloc extends Bloc<ExchangeratesEvent, ExchangeratesState> {
  ExchangeratesBloc() : super(ExchangeratesInitial()) {
    on<ExchangeratesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
