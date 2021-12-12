import 'package:flutter_test/flutter_test.dart';
import 'package:mukuru_app/models/exchange_rate_model.dart';

void main() {
  group('exchange rates model', () {
    test('ExchangeratesModelResponseToJson', () async {
      var exchangeRate = ExchangeRatesModel(disclaimer: 'disclaimer',license: 'kkk',base: 'kkk', rates: {"adn":222},timestamp: 20039900);
      var exchangeRateString = exchangeRatesModelToJson(exchangeRate);
      expect(exchangeRateString.contains('disclaimer'), true);
    });
  });
}
