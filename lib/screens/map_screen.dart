import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petpal_health/models/pet_location.dart';
import 'package:petpal_health/services/location_service.dart';
import 'package:petpal_health/widgets/bottom_nav_bar.dart';
import 'package:petpal_health/widgets/gradient_background.dart';
import 'package:petpal_health/models/locations.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _userLocation;
  static const LatLng _pGooglePlex = LatLng(41.9981, 21.4254);
  final LocationService _locationService = LocationService();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _locationService.requestPermission();
    _initUserLocation();
    _addMarkers();
  }

  Future<void> _initUserLocation() async {
    final locationData = await _locationService.getCurrentLocation();
    setState(() {
      _userLocation = LatLng(locationData.latitude, locationData.longitude);
    });
  }

  void _addMarkers() {
    for (var location in petLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location.name),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
              title: location.name,
              snippet: location.type,
              onTap: () {
                _showLocationDetails(location);
              }),
          icon: location.type == 'vet'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen),
        ),
      );
    }
  }

  void _showLocationDetails(PetLocation location) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                location.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  _navigateToLocation(location.latitude, location.longitude);
                },
                child: const Text('Navigate to this location'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Navigates to a selected marker
  void _navigateToLocation(double latitude, double longitude) async {
    Uri googleMapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
    );

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition:
              const CameraPosition(target: _pGooglePlex, zoom: 13),
          markers: _markers,
        ),
        bottomNavigationBar: BottomNavBar(context).getFooterMenu(2),
      ),
    );
  }
}
