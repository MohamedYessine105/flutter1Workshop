import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  // Use the same static list of movies
  static final List<Movie> _movies = [
    Movie(
      title: 'House of Dead',
      imagePath: 'assets/images/house_of_dead.jpeg',
      rating: 4.5,
      description: 'The House of the Dead and its 2022 remake take place in 1998...',
      price: 300,
    ),
    Movie(
      title: 'The Grudge',
      imagePath: 'assets/images/The_Grudge.jpeg',
      rating: 4.0,
      description: 'A deadly supernatural curse haunts anyone who enters.',
      price: 250,
    ),
    Movie(
      title: 'The Abyss',
      imagePath: 'assets/images/Abyss.jpeg',
      rating: 5.0,
      description: 'A civilian diving team searches for a lost submarine.',
      price: 350,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text('My Cart'),
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: _movies.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final movie = _movies[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    movie.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(movie.title),
                subtitle: Text('${movie.price} TND'),
                trailing: const Icon(Icons.remove_circle_outline),
              ),
            );
          },
        ),
      ),
    );
  }
}
