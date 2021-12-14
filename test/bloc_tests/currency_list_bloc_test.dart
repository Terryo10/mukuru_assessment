import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mukuru_app/bloc/currency_list_bloc/currencylist_bloc.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_provider.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_repository.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_provider.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';

class MockCurrencyListRepository extends Mock
    implements CurrencyListRepository {}

class MockExchangeRatesBloc extends Mock implements ExchangeRatesBloc {}

void main() {
  group('currency list bloc', () {
    test('returns instance of CurrencyListCloc', () {
      expect(
          () => CurrencylistBloc(
              currencyListRepository:
                  CurrencyListRepository(provider: CurrencyListProvider()),
              exchangeRatesBloc: ExchangeRatesBloc(
                  exchangeRatesRepository: ExchangeRatesRepository(
                      provider: ExchangeRatesProvider()))),
          returnsNormally);
    });
  });

  group('fetch currency List', () {
    CurrencyListRepository currencyListRepository;
    CurrencylistBloc currencylistBloc;
    ExchangeRatesBloc exchangeRatesBloc;

    setUp(() {
      currencyListRepository = MockCurrencyListRepository();
      exchangeRatesBloc = MockExchangeRatesBloc();
      currencylistBloc = CurrencylistBloc(
          currencyListRepository: currencyListRepository,
          exchangeRatesBloc: exchangeRatesBloc);
    });

    group('fetched exchange rates', () {
      blocTest<CurrencylistBloc, CurrencylistState>(
        'emits [initial, loading , and then Error states] ',
        build: () => CurrencylistBloc(
            currencyListRepository:
                CurrencyListRepository(provider: CurrencyListProvider()),
            exchangeRatesBloc: ExchangeRatesBloc(
                exchangeRatesRepository: ExchangeRatesRepository(
                    provider: ExchangeRatesProvider()))),
        act: (bloc) => bloc.add(GetCurrencies()),
        wait: const Duration(milliseconds: 300),
        expect: () =>
            [isA<CurrencylistLoadingState>(), isA<CurrencylistErrorState>()],
      );
    });
  });
}
