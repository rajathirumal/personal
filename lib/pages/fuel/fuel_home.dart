import 'package:flutter/material.dart';
import 'package:personal/pages/fuel/add_fuel.dart';

class FuelHome extends StatefulWidget {
  const FuelHome({super.key});

  @override
  State<FuelHome> createState() => _FuelHomeState();
}

class _FuelHomeState extends State<FuelHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Fuel home"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFuel(),
            ),
          );
        },
        label: const Text('Add fuel'),
      ),
    );
  }
}
