import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';
import 'signup_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart'; // <-- import ProfileScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('G-Store', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Transform.rotate(
              angle: -0.2,
              child: const Text(
                'DEMO',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),

      // -----------------------------
      //          BODY
      // -----------------------------
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Expanded grid fixes overflow
            Expanded(
              child: GridView.builder(
                itemCount: _movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return MovieCard(
                    movie: movie,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(movie: movie),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // -----------------------------
            //       FOOTER BUTTONS
            // -----------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 8), // extra safety
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('logout '),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text('Cart'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
