import 'package:mukuru_app/models/exchange_rate_model.dart';
import 'package:mukuru_app/repositories/exchange_rates_repositories/exchange_rates_provider.dart';

class ExchangeRatesRepository {
  final ExchangeRatesProvider provider;

  ExchangeRatesRepository({required this.provider});

  Future<ExchangeRatesModel> getExchangeRates() async {
    
    var data = await provider.getExchangeRates();

    return exchangeRatesModelFromJson(data);
  }
}
