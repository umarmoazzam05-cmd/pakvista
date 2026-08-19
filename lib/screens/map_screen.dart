import 'package:flutter/material.dart'; 
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'tourist_spot.dart';

class MapScreen extends StatefulWidget {
  final List<TouristSpot> spots;

  const MapScreen({super.key, required this.spots});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng _userLocation = const LatLng(33.6844, 73.0479);

  Future<void> _locateMe() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _userLocation = LatLng(pos.latitude, pos.longitude);
    });

    _mapController.move(_userLocation, 14);
  }

  void _showPlaceDialog(TouristSpot spot) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(spot.title),
        content: SingleChildScrollView(
          child: Text(
            spot.description + "\n\nLocation: ${spot.location}",
            style: const TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore on Map"),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _userLocation,
              initialZoom: 5.5,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.pakvista.app',
              ),

              /// TOURIST SPOT MARKERS
              MarkerLayer(
                markers: widget.spots.map((spot) {
                  return Marker(
                    point: LatLng(spot.latitude, spot.longitude),
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _showPlaceDialog(spot),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 36,
                      ),
                    ),
                  );
                }).toList(),
              ),

              /// USER LOCATION MARKER
              MarkerLayer(
                markers: [
                  Marker(
                    point: _userLocation,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// LOCATE ME BUTTON
          Positioned(
            bottom: 25,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              onPressed: _locateMe,
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
