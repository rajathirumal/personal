import 'package:flutter/material.dart';

class AddFuel extends StatefulWidget {
  const AddFuel({super.key});

  @override
  State<AddFuel> createState() => _AddFuelState();
}

class _AddFuelState extends State<AddFuel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            // padding: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text("Refueled for"),
                    hintText: "In  ₹",
                    prefixIcon: Icon(Icons.bubble_chart),
                    suffix: Text("₹"),
                    border: OutlineInputBorder(),
                  ),
                  // controller: fuelForTEC,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter money spent'
                      : (double.parse(value) == 0)
                          ? "Cannot be 0"
                          : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text("Price per liter"),
                    hintText: "In ₹",
                    prefixIcon: Icon(Icons.attach_money),
                    suffix: Text("₹"),
                    border: OutlineInputBorder(),
                  ),
                  // controller: marketPriceTEC,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter cost per liter'
                      : double.parse(value) < 50.0
                          ? "Canot be less than 50 ₹"
                          : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text("Liters fueld"),
                    hintText: "Liters",
                    prefixIcon: Icon(Icons.attach_money),
                    suffix: Text("L"),
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  // controller: marketPriceTEC,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter cost per liter'
                      : double.parse(value) < 50.0
                          ? "Canot be less than 50 ₹"
                          : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text("Oodometer reading"),
                    hintText: "In KM",
                    prefixIcon: Icon(Icons.speed_sharp),
                    suffix: Text("Km"),
                    border: OutlineInputBorder(),
                  ),
                  // controller: atKmTEC,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter current oodometer reading'
                      : (double.parse(value) < 100)
                          ? "Cannot be less than 100 KM"
                          : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    label: Text("Remaining"),
                    hintText: "In KM",
                    prefixIcon: Icon(Icons.grain_sharp),
                    suffix: Text("Km"),
                    border: OutlineInputBorder(),
                  ),
                  // controller: remainingKmTEC,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter remaining KM'
                      : null,
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Add fuel',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
