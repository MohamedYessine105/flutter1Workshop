import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBox = Hive.box('favorites');

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favorites"),
        backgroundColor: Colors.white,
      ),

      body: ValueListenableBuilder(
        valueListenable: favoritesBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text("No favorites yet."),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final data = box.getAt(index);
              final movie = Movie.fromMap(data);

              return ListTile(
                leading: Image.asset(movie.imagePath, width: 60, height: 60),
                title: Text(movie.title),
                subtitle: Text('${movie.price} TND'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    box.deleteAt(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
