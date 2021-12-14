import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mukuru_app/bloc/exchange_rates_bloc/exchangerates_bloc.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_provider.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_repository.dart';

class MockExchangeRatesRepository extends Mock
    implements ExchangeRatesRepository {}

void main() {
  group('Exchange Rates Bloc', () {
    test('returns an instance of Exchange Rates Bloc', () {
      expect(
          () => ExchangeRatesBloc(
              exchangeRatesRepository:
                  ExchangeRatesRepository(provider: ExchangeRatesProvider())),
          returnsNormally);
    });
  });

  group('fetch rates', () {
    ExchangeRatesRepository exchangeRatesRepository;
    ExchangeRatesBloc exchangeRateBloc;

    setUp(() {
      exchangeRatesRepository = MockExchangeRatesRepository();
      exchangeRateBloc =
          ExchangeRatesBloc(exchangeRatesRepository: exchangeRatesRepository);
    });

    group('fetched exchange rates', () {
      blocTest<ExchangeRatesBloc, ExchangeRatesState>(
        'emits [initial, loading , and then loaded states]',
        build: () => ExchangeRatesBloc(
            exchangeRatesRepository:
                ExchangeRatesRepository(provider: ExchangeRatesProvider())),
        act: (bloc) => bloc
            .add(GetExchangeRates(selectedCurrency: CurrencyRefinedModel())),
        wait: const Duration(milliseconds: 300),
        expect: () => [
          isA<ExchangeRatesLoadingState>(),
          isA<ExchangeRatesLoadedState>()
        ],
      );
    });
  });
}
