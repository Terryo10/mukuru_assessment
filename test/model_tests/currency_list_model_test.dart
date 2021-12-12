import 'package:flutter_test/flutter_test.dart';
import 'package:mukuru_app/models/currencyListModel.dart';

void main() {
  group('Currency List model', () {
    test('CurrencyListModelResponseToJson', () async {
      var currencies = {"ZAR":"South Africa"};
      var currenciesString = currencyListModelToJson(currencies);
      expect(currenciesString.contains('ZAR'), true);
    });
  });
}