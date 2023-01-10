import 'package:flutter/material.dart';

SnackBar sb5Sec({textContent}) {
  return SnackBar(
    content: textContent,
    duration: const Duration(seconds: 5),
  );
}
