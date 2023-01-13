import 'package:flutter/material.dart';

class AddFuel extends StatefulWidget {
  const AddFuel({super.key});

  @override
  State<AddFuel> createState() => _AddFuelState();
}

class _AddFuelState extends State<AddFuel> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Add fuel"),
      ),
    );
  }
}
