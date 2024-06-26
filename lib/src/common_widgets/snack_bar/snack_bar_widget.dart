import 'package:flutter/material.dart';

appSnackBar(BuildContext context, Color color, String label) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(label),
        backgroundColor: color,
      ),
    );

hideSnackBar(BuildContext context) =>
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

showSnackBar(BuildContext context, Color color, String label) {
  hideSnackBar(context);
  appSnackBar(context, color, label);
}
