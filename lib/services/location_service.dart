import 'package:location/location.dart';
import 'package:petpal_health/models/lcoation.dart';

class LocationService {
  final Location location = Location();

  Future<void> requestPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionStatus = await location.requestPermission();
    if (permissionStatus == PermissionStatus.granted) {
      final locationData = await location.getLocation();
      print(
          "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}");
    } else {
      print("Location permission denied");
    }
  }

  Future<Locations> getCurrentLocation() async {
    final position = await location.getLocation();
    return Locations(
        latitude: position.latitude!, longitude: position.longitude!);
  }
}
