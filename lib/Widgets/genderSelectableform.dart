import 'package:flutter/material.dart';

class GenderFormField extends StatelessWidget {
  final String? gender;
  final ValueChanged<String?> onChanged;

  const GenderFormField({
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          'Gender',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Radio<String>(
              value: "Man",
              groupValue: gender,
              onChanged: onChanged,
            ),
            Text("Man"),
            SizedBox(width: 20),
            Radio<String>(
              value: "Woman",
              groupValue: gender,
              onChanged: onChanged,
            ),
            Text("Woman"),
          ],
        ),
      ],
    );
  }
}
