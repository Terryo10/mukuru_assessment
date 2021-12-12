import 'package:flutter_test/flutter_test.dart';
import 'package:mukuru_app/models/refined_currency_list_model.dart';

void main() {
  group('refined currencies model', () {
    test('currencyRefinedModelResponseToJson', () async {
      var refinedCurrency = CurrencyRefinedModel(name: 'South African Rand', abr: 'ZAR',currentRate: 16, warningRate: 15 );
      var refinedCurrencyString = currencyRefinedModelToJson(refinedCurrency);
      expect(refinedCurrencyString.contains('ZAR'), true);
    });
  });
}