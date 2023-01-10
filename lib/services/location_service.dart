import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as locationPackage;

class LocationService {
  Future<Map<dynamic, dynamic>> getAddress(
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

  Future<Map<dynamic, dynamic>> getLocationPermission() async {
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