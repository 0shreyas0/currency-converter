import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiUrl = "https://api.exchangerate-api.com/v4/latest/";

  Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl$baseCurrency'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load exchange rates');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<double> convertCurrency(String fromCurrency, String toCurrency, double amount) async {
    try {
      final exchangeRates = await fetchExchangeRates(fromCurrency);
      double rate = exchangeRates["rates"][toCurrency];

      return amount * rate;
    } catch (e) {
      throw Exception('Conversion error: $e');
    }
  }
}
