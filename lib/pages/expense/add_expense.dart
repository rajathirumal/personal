import 'package:flutter/material.dart';
import 'package:personal/models/location_model.dart';
import 'package:personal/widgets/selected_friend_card.dart';
import 'package:location/location.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
// import 'package:flutter/services.dart';

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

  // final List<Widget> friends = <Widget>[
  //   Expanded(child: Text("Self")),
  //   Expanded(child: Text("Friend 1")),
  //   Expanded(child: Text("Friend 2")),
  //   Expanded(child: Text("Friend 3")),
  // ];

  List<String> selectedFriends = [];

  final _expenseForm = GlobalKey<FormState>();
  TextEditingController locationTEC = TextEditingController();

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
                      onPressed: () {
                        if (_expenseForm.currentState!.validate()) {
                          if (locationTEC.text.isEmpty) {
                            print("location empty");
                            MyLocation ml = _getLocationPermission();
                            print(_getAddress(ml.latitude, ml.longitude));
                            // _getGeoLocationPermission();
                          }
                        }
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

  String _getAddress(double lat, double lon) {
    String rAddress = "Chennai, TamilNadu, India";

    GBLatLng position = GBLatLng(lat: lat, lng: lon);
    GeocoderBuddy.findDetails(position).then((data) {
      // print(data.address.stateDistrict);
      rAddress =
          "${data.address.stateDistrict}, ${data.address.state}, ${data.address.country}";
      return rAddress;
    });

    return rAddress;
  }

  MyLocation _getLocationPermission() {
    // Default Chennai ==> 13.0827, 80.2707
    Location location = Location();
// Handel location service checks
    location.serviceEnabled().then((isServiceEnabled) {
      // if location service not enabled
      if (!isServiceEnabled) {
        // request for location service
        location.requestService().then((resStatus) {
          isServiceEnabled = resStatus;
        });
      }
      // if location not enabled after requesting prompt user to provide via snackbar
      if (!isServiceEnabled) {
        const snackBar = SnackBar(
          content: Text('Location should be enabled to save the data \n'
              ' Try switching on the location'),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      // if location is on
      else {
        // Handel app location permission checks
        location.hasPermission().then((permissionStatus) {
          // App location permission is rejected
          if (permissionStatus == PermissionStatus.denied) {
            // request for app location permission
            location.requestPermission().then((appPermissionStatus) {
              permissionStatus = appPermissionStatus;
            });
          }
          // app location permission not provided after retry
          if (permissionStatus == PermissionStatus.denied) {
            const snackBar = SnackBar(
              content: Text(
                  'Location permission be provided for the app to save the data \n'
                  ' Try switching on the location'),
              duration: Duration(seconds: 5),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            location.getLocation().then((locationData) {
              return MyLocation(
                latitude: locationData.latitude ?? 11.1085,
                longitude: locationData.longitude ?? 77.3411,
              );
            });
          }
        });
      }
    });
    return MyLocation(
      latitude: 11.1085,
      longitude: 77.3411,
    );
  }
}
