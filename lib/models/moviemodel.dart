class Moviemodel{
  final String name;
  final String url;
  final String language;
  final String rating;
  final String image;
  final String summary;
  Moviemodel({//constructor
    required this.name,
    required this.url,
    required this.language,
    required this.rating,
    required this.image,
    required this.summary

});
  // Factory method to convert API response to the app model
  static Moviemodel ApiToApp(Map<String, dynamic> movie) {
    return Moviemodel(
      name: movie['name'] ?? 'All American',
      url: movie['url'] ?? 'https://www.tvmaze.com/shows/34653/all-american',
      language: movie['language'] ?? 'English',
      rating: movie['rating']?['average']?.toString() ?? '6.1', // Handle rating nullability
      image: movie['image']?['medium'] ?? 'https://static.tvmaze.com/uploads/images/medium_portrait/425/1064746.jpg', // Extracting the medium image URL
      summary: movie['summary'] ?? 'When a rising high school football player from South Central L.A. is recruited to play for Beverly Hills High, the wins, losses and struggles of two families from vastly different worlds — Compton and Beverly Hills — begin to collide. Inspired by the life of pro football player Spencer Paysinger',
    );
  }




}