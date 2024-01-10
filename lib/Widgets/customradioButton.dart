import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final String label;
  final String value;
  final String groupValue;
  final Function(String?) onChanged;

  const CustomRadio({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        Radio.adaptive(
          value: value,
          groupValue: groupValue,
          onChanged: (newValue) {
            onChanged(newValue);
          },
        ),
      ],
    );
  }
}
