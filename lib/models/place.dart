import 'dart:io';

class Place {
  final String id;
  final String title;
  final File image;
  final Location location;

  const Place({required this.id, required this.title, required this.image, required this.location});
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  const Location({required this.longitude, required this.latitude, required this.address});
}