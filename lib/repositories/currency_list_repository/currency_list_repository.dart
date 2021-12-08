import 'package:mukuru_app/models/currencyListModel.dart';
import 'package:mukuru_app/repositories/currency_list_repository/currency_list_provider.dart';

class CurrencyListRepository {
  final CurrencyListProvider provider;

  CurrencyListRepository({required this.provider});

  Future getCurrencyList() async {
    var data = await provider.getCurrencies();

    return currencyListModelFromJson(data);
  }
}
