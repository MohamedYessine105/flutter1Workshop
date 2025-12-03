import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';
import '../widgets/movie_card.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Box<dynamic> favoritesBox;
  late TabController _tabController;

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
  void initState() {
    super.initState();
    favoritesBox = Hive.box('favorites');
    _tabController = TabController(length: 3, vsync: this);
  }

  void toggleFavorite(Movie movie) {
    final isFavorite =
    favoritesBox.values.any((m) => m['title'] == movie.title);

    if (isFavorite) {
      final keyToRemove = favoritesBox.keys.firstWhere(
              (key) => favoritesBox.get(key)['title'] == movie.title);
      favoritesBox.delete(keyToRemove);
    } else {
      favoritesBox.add(movie.toMap());
    }

    setState(() {}); // Refresh UI immediately
  }

  Widget buildMovieGrid() {
    return ValueListenableBuilder(
      valueListenable: favoritesBox.listenable(),
      builder: (context, Box<dynamic> box, _) {
        return GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final movie = _movies[index];
            final isFavorite =
            box.values.any((m) => m['title'] == movie.title);

            return Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(movie: movie),
                      ),
                    );
                    setState(() {});
                  },
                  child: MovieCard(movie: movie),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      toggleFavorite(movie);
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('G-Store', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.deepOrange,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
            Tab(icon: Icon(Icons.person), text: 'Profile'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildMovieGrid(),
          const FavoritesScreen(),
          const ProfileScreen(),
        ],
      ),
    );
  }
}
