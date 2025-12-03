class Movie {
  final int? id; // Add this
  final String title;
  final String imagePath;
  final double rating;
  final String description;
  final double price;

  const Movie({
    this.id, // optional
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'imagePath': imagePath,
      'rating': rating,
      'description': description,
      'price': price,
    };
  }

  factory Movie.fromMap(Map data) {
    return Movie(
      id: data['id'], // map id from DB
      title: data['title'],
      imagePath: data['imagePath'],
      rating: (data['rating'] as num).toDouble(),
      description: data['description'],
      price: (data['price'] as num).toDouble(),
    );
  }
}
