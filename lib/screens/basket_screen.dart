import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/movie.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late Future<List<Movie>> basketMovies;

  @override
  void initState() {
    super.initState();
    basketMovies = DBHelper().getBasketMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Movie>>(
        future: basketMovies,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final movies = snapshot.data!;
          if (movies.isEmpty) return const Center(child: Text('Basket is empty'));

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.asset(movie.imagePath, width: 50, fit: BoxFit.cover),
                title: Text(movie.title),
                subtitle: Text('${movie.price.toStringAsFixed(0)} DT'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await DBHelper().deleteMovie(movie.id!); // delete using the actual ID
                    setState(() {
                      basketMovies = DBHelper().getBasketMovies(); // refresh the list
                    });
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