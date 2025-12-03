class Movie {
  final String title;
  final String imagePath;
  final double rating;
  final String description;
  final double price;

  const Movie({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.description,
    required this.price,
  });

  // Convert Movie → Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagePath': imagePath,
      'rating': rating,
      'description': description,
      'price': price,
    };
  }

  // Convert Map → Movie
  factory Movie.fromMap(Map data) {
    return Movie(
      title: data['title'],
      imagePath: data['imagePath'],
      rating: (data['rating'] as num).toDouble(),
      description: data['description'],
      price: (data['price'] as num).toDouble(),
    );
  }
}
