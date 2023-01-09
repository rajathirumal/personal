import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:personal/widgets/selected_friend_card.dart';
import 'package:location/location.dart' as locationPackage;
import 'package:flutter/services.dart';

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
                            _getLocationPermission().then((dataMap) {
                              print(dataMap.toString());
                              if (dataMap["hasError"]) {
                                var snackBar = SnackBar(
                                  content: Text(dataMap["eMsg"].toString()),
                                  duration: const Duration(seconds: 5),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                // Call get location name
                                _getAddress(
                                        lat: dataMap["data"]["latitude"],
                                        lon: dataMap["data"]["longitude"])
                                    .then((addressMap) {
                                  print(">> " + addressMap["data"]);
                                });
                              }
                            });

                            // print(">>> " +
                            //     ml.latitude.toString() +
                            //     "-----" +
                            //     ml.longitude.toString());
                            // print(_getAddress(ml.latitude, ml.longitude));
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

  Future<Map<dynamic, dynamic>> _getAddress(
      {required double lat, required double lon}) async {
    String rAddress = "Default city, Default state, Default country";
    Map rMap = {"hasError": true, "eMsg": "default eMsg"};

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    if (placemarks.isNotEmpty) {
      var data = placemarks.first;
      // rAddress = "${data.subAdminArea}, ${data.adminArea}, ${data.countryName}";
      rAddress =
          "${data.subLocality}, ${data.administrativeArea}, ${data.country}";
      rMap.remove("hasError");
      rMap.remove("eMsg");
      rMap.addAll({"hasError": false});
      rMap.addAll({"data": rAddress});

      return Future.value(rMap);
    } else {
      rMap.remove("hasError");
      rMap.remove("eMsg");
      rMap.addAll({"hasError": false});
      rMap.addAll({"eMgs": "No data available"});
      return Future.value(rMap);
    }
  }

  Future<Map<dynamic, dynamic>> _getLocationPermission() async {
    locationPackage.Location location = locationPackage.Location();

    bool isLocationServiceEnabled;
    locationPackage.PermissionStatus permissionGranted;
    Map rMap = {"hasError": true, "eMsg": "default eMsg"};

    isLocationServiceEnabled = await location.serviceEnabled();
    if (!isLocationServiceEnabled) {
      isLocationServiceEnabled = await location.requestService();
      if (!isLocationServiceEnabled) {
        rMap.remove("hasError");
        rMap.remove("eMsg");
        rMap.addAll({"hasError": true});
        rMap.addAll({
          "eMsg":
              "Location should be enabled to save the data.\n Try switching on the location"
        });
        return Future.value(rMap);
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == locationPackage.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != locationPackage.PermissionStatus.granted) {
        rMap.remove("hasError");
        rMap.remove("eMsg");
        rMap.addAll({"hasError": true});
        rMap.addAll({
          "eMsg":
              "Location permission be provided for the app to save the data \n Try switching on the location"
        });
        return Future.value(rMap);
      }
    }
    // _locationData = await location.getLocation();
    await location.getLocation().then((value) {
      rMap.remove("hasError");
      rMap.remove("eMsg");
      rMap.addAll({"hasError": false});
      rMap.addAll({
        "data": {
          "latitude": value.latitude ?? 11.1085,
          "longitude": value.longitude ?? 77.3411
        }
      });
      return Future.value(rMap);
    }).onError((error, stackTrace) {
      rMap.remove("hasError");
      rMap.remove("eMsg");
      rMap.addAll({"hasError": true});
      rMap.addAll({"eMsg": error.toString()});
      return Future.value(rMap);
    });
    return Future.value(rMap);
  }
}
