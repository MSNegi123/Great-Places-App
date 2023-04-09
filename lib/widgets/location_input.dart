import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places_app/helpers/location_helper.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 150,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _previewImageUrl != null
              ? Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: selectLocation,
              icon: const Icon(Icons.map),
              label: const Text("Select on Map"),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> getCurrentLocation() async {
    try{
      var locData = await Location().getLocation();
      debugPrint("Latitude:${locData.latitude}");
      debugPrint("Longitude:${locData.longitude}");
      widget.onSelectPlace(locData.latitude, locData.longitude);
      showLocationPreview(locData.latitude, locData.longitude);
    }catch(error){
      return;
    }
  }

  Future<void> selectLocation() async {
    var _selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const MapScreen(isSelecting: true),
      ),
    );
    if (_selectedLocation == null) return;
    debugPrint("Latitude:${_selectedLocation.latitude}");
    widget.onSelectPlace(_selectedLocation.latitude, _selectedLocation.longitude);
    showLocationPreview(_selectedLocation.latitude, _selectedLocation.longitude);
  }

  void showLocationPreview(double? lat, double? lng) {
    var staticMapPreviewUrl = LocationHelper.generateLocationPreviewImage(lat, lng);
    setState(() {
      _previewImageUrl = staticMapPreviewUrl;
    });
  }
}
