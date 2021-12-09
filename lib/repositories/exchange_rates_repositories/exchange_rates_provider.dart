import 'dart:convert';

import 'package:mukuru_app/data/strings.dart';
import 'package:http/http.dart' as http;

class ExchangeRatesProvider {
  Future getExchangeRates() async {
    String url = AppStrings.exchangeRates;

    try {
      var response = await http.get(Uri.parse(url));
    

      if (response.statusCode == 200) {
        return response.body;
      } else {
        var data = jsonDecode(response.body);
        throw Exception(data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
