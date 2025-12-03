import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';
import '../db/db_helper.dart'; // Import DBHelper for SQLite

class DetailScreen extends StatefulWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Box favoritesBox;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box('favorites');
    // Check if the movie is already in favorites
    isFavorite = favoritesBox.values.any((m) => m['title'] == widget.movie.title);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        // Remove from favorites
        final keyToRemove = favoritesBox.keys.firstWhere(
                (key) => favoritesBox.get(key)['title'] == widget.movie.title);
        favoritesBox.delete(keyToRemove);
        isFavorite = false;
      } else {
        // Add to favorites only if not already there
        if (!favoritesBox.values.any((m) => m['title'] == widget.movie.title)) {
          favoritesBox.add(widget.movie.toMap());
        }
        isFavorite = true;
      }
    });
  }

  Future<void> addToBasket() async {
    await DBHelper().insertMovie(widget.movie);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Movie added to basket!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(movie.title),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  movie.imagePath,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              movie.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            Center(
              child: Text(
                '${movie.price.toStringAsFixed(0)} DT',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Acheter button
                ElevatedButton.icon(
                  onPressed: addToBasket,
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Acheter', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // Favorite button
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 32,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}