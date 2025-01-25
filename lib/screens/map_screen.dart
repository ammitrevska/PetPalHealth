import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petpal_health/services/location_service.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _pGooglePlex = LatLng(41.9981, 21.4254);
  LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _locationService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),
        body: const GoogleMap(
          initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(2),
      ),
    );
  }
}
