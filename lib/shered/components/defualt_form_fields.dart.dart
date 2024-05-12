import 'package:flutter/material.dart';

final List<String> items = [
  'Home',
  'School',
  'Workout',
  'Job',
];

Widget defaultTextform({
  required IconData icon,
  TextInputType? keyboardType,
  void Function()? onTap,
  required String label,
  required controller,
  required String? Function(String?)? validation,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: TextFormField(
        onTap: onTap,
        validator: validation,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          icon: Icon(
            icon,
            size: 30.0,
          ),
          label: Text(label),
        ),
      ),
    );
Widget defaultUpdateTextform({
  required IconData icon,
  void Function()? onTap,
  TextInputType? keyboardType,
  required String label,
  required controller,
  required String? Function(String?)? validation,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: TextFormField(
        onTap: onTap,
        validator: validation,
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.multiline,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            size: 30.0,
          ),
          label: Text(label),
        ),
      ),
    );

Color? chooseTaskColor(String tag) {
  if (tag == 'Home') {
    return Colors.blue;
  } else if (tag == 'School') {
    return Colors.green;
  } else if (tag == 'Workout') {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
