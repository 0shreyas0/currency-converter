import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final double convertedAmount;
  final String selectedToCurrency;
  final Function(String?) onCurrencyChanged;
  final Map<String, String> currencyFlags;

  const ResultDisplay({
    super.key,
    required this.convertedAmount,
    required this.selectedToCurrency,
    required this.onCurrencyChanged,
    required this.currencyFlags,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            convertedAmount > 0 ? convertedAmount.toStringAsFixed(2) : 'Converted amount',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
          DropdownButton<String>(
            dropdownColor: Colors.black,
            value: selectedToCurrency,
            underline: Container(),
            onChanged: onCurrencyChanged,
            items: currencyFlags.keys.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Row(
                  children: [
                    Text(currencyFlags[value] ?? ''),
                    const SizedBox(width: 8),
                    Text(value, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
