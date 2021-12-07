import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'currencylist_event.dart';
part 'currencylist_state.dart';

class CurrencylistBloc extends Bloc<CurrencylistEvent, CurrencylistState> {
  CurrencylistBloc() : super(CurrencylistInitial()) {
    on<CurrencylistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
