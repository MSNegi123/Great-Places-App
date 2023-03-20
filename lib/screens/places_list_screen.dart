import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_place.dart';
import '../screens/add_places_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                Navigator.pushNamed(context, AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        builder: (_, greatPlace, ch) => greatPlace.places.length<=0
            ? ch!
            : ListView.builder(
                itemCount: greatPlace.places.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlace.places[index].image),
                  ),
                  title: Text(greatPlace.places[index].title),
                ),
              ),
        child: const Center(
          child: Text("No Places added yet. Go and add some"),
        ),
      ),
    );
  }
}
