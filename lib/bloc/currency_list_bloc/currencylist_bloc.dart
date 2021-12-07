import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';

part 'currencylist_event.dart';
part 'currencylist_state.dart';

class CurrencylistBloc extends Bloc<CurrencylistEvent, CurrencylistState> {
  final CurrencyListRepository currencyListRepository;
  CurrencylistBloc({
    required this.currencyListRepository,
  }) : super(CurrencylistInitialState());

  @override
  Stream<CurrencylistState> mapEventToState(
    CurrencylistEvent event,
  ) async* {
    //action comes here lol
  }
}
