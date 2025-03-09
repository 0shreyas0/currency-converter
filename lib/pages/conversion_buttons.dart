import 'package:flutter/material.dart';

class ConversionButtons extends StatelessWidget {
  final VoidCallback onSwapValues;
  final VoidCallback onConvert;
  final VoidCallback onSwapCurrencies;

  const ConversionButtons({
    super.key,
    required this.onSwapValues,
    required this.onConvert,
    required this.onSwapCurrencies,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton(Icons.swap_vert, Colors.grey[800]!, onSwapValues),
        const SizedBox(width: 30),
        _buildButton(Icons.arrow_downward, Colors.blue, onConvert),
        const SizedBox(width: 30),
        _buildButton(Icons.swap_horiz, Colors.grey[800]!, onSwapCurrencies),
      ],
    );
  }

  Widget _buildButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: Colors.white, size: 40),
      ),
    );
  }
}
