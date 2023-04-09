import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places_app/helpers/location_helper.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Place findPlaceById(String id){
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String pickedTitle, File pickedImage, Location _pickedLocation) async {
    final placeAddr = await LocationHelper.getPlaceAddress(
        _pickedLocation.latitude, _pickedLocation.longitude);
    final _updatedLocation = Location(
        longitude: _pickedLocation.longitude,
        latitude: _pickedLocation.latitude,
        address: placeAddr);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: _updatedLocation,
    );

    _places.add(newPlace);
    notifyListeners();
    var affectedRowsCount = await DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': _updatedLocation.latitude,
      'loc_long': _updatedLocation.longitude,
      'address': _updatedLocation.address,
    });
    debugPrint("No of affected rows:$affectedRowsCount");
  }

  Future<void> fetchAndSetPlaces() async {
    var userPlacesList = await DBHelper.getData("user_places");
    _places = userPlacesList
        .map(
          (userPlace) => Place(
            id: userPlace['id'],
            title: userPlace['title'],
            image: File(userPlace['image']),
            location: Location(longitude: userPlace['loc_long'], latitude: userPlace['loc_lat'], address: userPlace['address']),
          ),
        )
        .toList();
    notifyListeners();
  }
}
