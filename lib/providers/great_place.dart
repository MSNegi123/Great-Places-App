import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  void addPlace(String pickedTitle, File pickedImage) {
    _places.add(
      Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        image: pickedImage,
        location: const Location(longitude: 0.0, latitude: 0.0, address: ''),
      ),
    );
    notifyListeners();
  }
}
