import 'package:http/http.dart' as http;
import 'dart:convert';

const GOOGLE_API_KEY = "AIzaSyAFhzSZjVtw7Kf7UyKl08bzDySYNnUqVjw";

class LocationHelper {
  static String generateLocationPreviewImage(double? latitude, double? longitude) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,&$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Alabel:S%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double latitude, double longitude) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
