import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final List<String> friends = <String>[
    "Self",
    "Friend 1",
    "Friend 2",
    "Friend 3"
  ];

  // final List<Widget> friends = <Widget>[
  //   Expanded(child: Text("Self")),
  //   Expanded(child: Text("Friend 1")),
  //   Expanded(child: Text("Friend 2")),
  //   Expanded(child: Text("Friend 3")),
  // ];

  List<String> selectedFriends = [];

  final _expenseForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new expense")),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _expenseForm,
              child: Column(
                children: [
                  // Item name
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        // controller: emailController,
                        decoration: const InputDecoration(
                          label: Text("Item Name"),
                          hintText: "Chocolates",
                          prefixIcon:
                              Icon(Icons.shopping_cart_checkout_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Count required';
                          }
                          if (value.length < 3) {
                            return 'Enter a valid item name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Item count / Price
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                // controller: emailController,
                                decoration: const InputDecoration(
                                  label: Text("Count"),
                                  hintText: "10",
                                  prefixIcon: Icon(Icons.numbers_rounded),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Cannot be empty';
                                  }
                                  if (int.parse(value.toString()) < 1) {
                                    return "Count cannot be 0";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                            child: VerticalDivider(
                              endIndent: 5.0,
                              indent: 5.0,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                // controller: emailController,
                                decoration: const InputDecoration(
                                  label: Text("Price"),
                                  hintText: "5",
                                  prefixIcon: Icon(Icons.money),
                                  suffix: Text("₹"),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Cannot be empty';
                                  }
                                  if (int.parse(value.toString()) < 1) {
                                    return "Count cannot be 0";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Self or friend
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          label: Text("For"),
                          hintText: "Self / Friend name",
                          prefixIcon: Icon(Icons.person),
                        ),
                        items: friends
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  //  location optional
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        // controller: emailController,
                        decoration: const InputDecoration(
                          label: Text("Location (Optional)"),
                          hintText: "Jio Mart / Amazon",
                          prefixIcon: Icon(Icons.pin_drop_rounded),
                        ),
                        validator: (value) {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style:
                          ButtonStyle(elevation: MaterialStateProperty.all(20)),
                      icon: const Icon(Icons.save, color: Colors.white),
                      onPressed: () {},
                      label: const Text('Save expense',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
