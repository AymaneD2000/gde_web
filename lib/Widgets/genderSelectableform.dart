import 'package:flutter/material.dart';

class GenderFormField extends StatelessWidget {
  final String? gender;
  final ValueChanged<String?> onChanged;

  const GenderFormField({
    super.key,
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Gender',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Radio<String>(
              value: "Man",
              groupValue: gender,
              onChanged: onChanged,
            ),
            const Text("Man"),
            const SizedBox(width: 20),
            Radio<String>(
              value: "Woman",
              groupValue: gender,
              onChanged: onChanged,
            ),
            const Text("Woman"),
          ],
        ),
      ],
    );
  }
}
