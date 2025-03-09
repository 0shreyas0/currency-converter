import 'package:flutter/material.dart';

class CurrencyInput extends StatelessWidget {
  final TextEditingController controller;
  final String selectedCurrency;
  final Function(String?) onCurrencyChanged;
  final Map<String, String> currencyFlags;

  const CurrencyInput({
    super.key,
    required this.controller,
    required this.selectedCurrency,
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
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 18, color: Colors.white),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter amount',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          DropdownButton<String>(
            dropdownColor: Colors.black,
            value: selectedCurrency,
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
