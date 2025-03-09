import 'package:flutter/material.dart';
import '../pages/currency_input.dart';
import '../pages/conversion_buttons.dart';
import '../pages/result_display.dart';
import '../services/currency_service.dart';
import '../widgets/error_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0.0;
  String _selectedFromCurrency = 'USD';
  String _selectedToCurrency = 'INR';

  final Map<String, String> currencyFlags = {
    'USD': '🇺🇸', 'EUR': '🇪🇺', 'GBP': '🇬🇧', 'INR': '🇮🇳',
    'AUD': '🇦🇺', 'CAD': '🇨🇦', 'CHF': '🇨🇭', 'CNY': '🇨🇳',
    'JPY': '🇯🇵', 'MXN': '🇲🇽', 'BRL': '🇧🇷', 'ZAR': '🇿🇦',
    'SAR': '🇸🇦', 'RUB': '🇷🇺', 'SGD': '🇸🇬', 'NZD': '🇳🇿',
    'KRW': '🇰🇷', 'TRY': '🇹🇷', 'THB': '🇹🇭', 'AED': '🇦🇪',
  };

  Future<void> _convertCurrency() async {
    if (_amountController.text.isEmpty || double.tryParse(_amountController.text) == null) {
      if (mounted) {
        ErrorDialog.show(context, 'Enter a valid amount');
      }
      return;
    }

    try {
      double convertedAmount = await CurrencyService().convertCurrency(
        _selectedFromCurrency, _selectedToCurrency, double.parse(_amountController.text),
      );

      if (mounted) {
        setState(() {
          _convertedAmount = convertedAmount;
        });
      }
    } catch (e) {
      if (mounted) {
        ErrorDialog.show(context, 'Conversion failed: $e');
      }
    }
  }

  void _swapCurrencies() {
    setState(() {
      String temp = _selectedFromCurrency;
      _selectedFromCurrency = _selectedToCurrency;
      _selectedToCurrency = temp;
    });
  }

  void _swapInputOutputValues() {
    setState(() {
      String temp = _amountController.text;
      if (temp.isEmpty || double.tryParse(temp) == null) return;

      _amountController.text = _convertedAmount > 0 ? _convertedAmount.toStringAsFixed(2) : '';
      _convertedAmount = double.tryParse(temp) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CurrencyInput(
                controller: _amountController,
                selectedCurrency: _selectedFromCurrency,
                onCurrencyChanged: (value) => setState(() => _selectedFromCurrency = value!),
                currencyFlags: currencyFlags,
              ),
              const SizedBox(height: 30),
              ConversionButtons(
                onSwapValues: _swapInputOutputValues,
                onConvert: _convertCurrency,
                onSwapCurrencies: _swapCurrencies,
              ),
              const SizedBox(height: 30),
              ResultDisplay(
                convertedAmount: _convertedAmount,
                selectedToCurrency: _selectedToCurrency,
                onCurrencyChanged: (value) => setState(() => _selectedToCurrency = value!),
                currencyFlags: currencyFlags,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
