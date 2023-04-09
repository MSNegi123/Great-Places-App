import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_place.dart';
import 'package:great_places_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = "place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final _selectedPlace = Provider.of<GreatPlaces>(context).findPlaceById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              _selectedPlace.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _selectedPlace.location.address,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog:true,
                builder: (_) => MapScreen(initialLocation:_selectedPlace.location,),
              ),
            ),
            child: const Text("View on Map"),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
