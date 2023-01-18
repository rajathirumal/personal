import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal/models/add_expense_model.dart';
import 'package:personal/services/auth_services.dart';
import 'package:personal/services/expense_service.dart';
import 'package:personal/widgets/selected_friend_card.dart';
import 'package:personal/services/location_service.dart';
import 'package:personal/widgets/snack_bars.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

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
    "Friend 3",
    "Friend 4",
    "Friend 5",
    "Friend 6",
    "Friend 7",
    "Friend 8",
    "Friend 9",
    "Friend 10"
  ];
  final List<String> _selectedFriends = [];

  List<String> selectedFriends = [];

  final _expenseForm = GlobalKey<FormState>();
  TextEditingController itemNameTEC = TextEditingController();
  TextEditingController countTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController locationTEC = TextEditingController();

  void loadCurrentAddress() {
    LocationService locationService = LocationService();
    locationService.getLocationPermission().then((dataMap) {
      // print(dataMap.toString());
      if (dataMap["hasError"]) {
        ScaffoldMessenger.of(context).showSnackBar(
            sb5Sec(textContent: Text(dataMap["eMsg"].toString())));
      } else {
        // Call get location name
        locationService
            .getAddress(
                lat: dataMap["data"]["latitude"],
                lon: dataMap["data"]["longitude"])
            .then((addressMap) {
          // print(">> from init " + addressMap["data"]);
          locationTEC.text = addressMap["data"];
        });
      }
    });
  }

  @override
  void initState() {
    // loadCurrentAddress();
    LocationService locationService = LocationService();
    locationService.getLocationPermission().then((dataMap) {
      // print(dataMap.toString());
      if (dataMap["hasError"]) {
        ScaffoldMessenger.of(context).showSnackBar(
          sb5Sec(textContent: Text(dataMap["eMsg"].toString())),
        );
      } else {
        // Call get location name
        locationService
            .getAddress(
                lat: dataMap["data"]["latitude"],
                lon: dataMap["data"]["longitude"])
            .then((addressMap) {
          // print(">> from init " + addressMap["data"]);
          locationTEC.text = addressMap["data"];
        });
      }
    });
    super.initState();
  }

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
                        controller: itemNameTEC,
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
                                controller: countTEC,
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
                                controller: priceTEC,
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
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              if (_selectedFriends.contains(value)) {
                                _selectedFriends.remove(value);
                              } else {
                                _selectedFriends.add(value);
                              }
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _selectedFriends.map((selectedFriend) {
                        return SelectedFriendCard(friendName: selectedFriend);
                      }).toList(),
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
                        controller: locationTEC,
                        decoration: const InputDecoration(
                          label: Text("Location (Optional)"),
                          hintText: "Jio Mart / Amazon",
                          prefixIcon: Icon(Icons.pin_drop_rounded),
                        ),
                        // validator: (value) {},
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
                      onPressed: () {
                        if (_expenseForm.currentState!.validate()) {
                          if (locationTEC.text.isEmpty) {
                            sleep(const Duration(seconds: 3));
                            if (locationTEC.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                sb5Sec(
                                  textContent:
                                      "We are unable to get your location \n Please privide the location information",
                                ),
                              );
                            }
                          } else {
                            // proceed to Firebase submit
                            Provider.of<ExpenseService>(context, listen: false)
                                .addAnExpense(
                              newExpense: SingleExpense(
                                  username: context
                                      .read<AuthServices>()
                                      .currentLoggedInUser!
                                      .email!
                                      .split("@")[0],
                                  expenseID: const Uuid().v1(),
                                  itemName: itemNameTEC.text,
                                  count: countTEC.text,
                                  price: priceTEC.text,
                                  friends: _selectedFriends,
                                  location: locationTEC.text,
                                  timestamp: DateTime.now().toString()),
                            );
                          }
                        }
                        Navigator.pop(context);
                      },
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
