import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final Location initialLocation;
  final bool isSelecting;

  const MapScreen(
      {this.initialLocation =
          const Location(longitude: 28.6129, latitude: 77.2295, address: ""),
      this.isSelecting = false});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Map"),
        centerTitle: true,
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.pop(context, _pickedLocation),
              icon: const Icon(Icons.done),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 16),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: _pickedLocation != null && widget.isSelecting
            ? {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _pickedLocation!,
                ),
              }
            : {},
      ),
    );
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }
}
