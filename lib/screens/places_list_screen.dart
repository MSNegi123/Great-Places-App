import 'package:flutter/material.dart';
import 'package:great_places_app/screens/place_details_screen.dart';
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
      body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<GreatPlaces>(
                builder: (_, greatPlace, ch) => greatPlace.places.length <= 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlace.places.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context,  PlaceDetailsScreen.routeName, arguments: greatPlace.places[index].id);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatPlace.places[index].image),
                            ),
                            title: Text(greatPlace.places[index].title),
                            subtitle: Text(greatPlace.places[index].location.address),
                          ),
                        ),
                      ),
                child: const Center(
                  child: Text("No Places added yet. Go and add some"),
                ),
              );
            }
          }),
    );
  }
}
