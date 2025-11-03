class Shop {
  final String id;
  final String name;
  final String description;
  final double rating;
  final List<Review> reviews;
  final String status; // 'pending', 'approved', 'rejected'

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.reviews,
    this.status = 'pending',
  });
}

class Review {
  final String reviewer;
  final String comment;
  final double rating;

  Review({
    required this.reviewer,
    required this.comment,
    required this.rating,
  });
}