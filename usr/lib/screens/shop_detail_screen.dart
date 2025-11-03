import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/shop.dart';

class ShopDetailScreen extends StatefulWidget {
  final Shop shop;

  const ShopDetailScreen({super.key, required this.shop});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final _reviewController = TextEditingController();
  final _ratingController = TextEditingController(); // Simple text field for now

  void _addReview() {
    if (_reviewController.text.isNotEmpty && _ratingController.text.isNotEmpty) {
      final newReview = Review(
        reviewer: 'New User', // Placeholder
        comment: _reviewController.text,
        rating: double.tryParse(_ratingController.text) ?? 0.0,
      );
      setState(() {
        widget.shop.reviews.add(newReview);
      });
      _reviewController.clear();
      _ratingController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.shop.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.shop.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4.0),
                Text(
                  '${widget.shop.rating} (${widget.shop.reviews.length} reviews)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Text(
              'Reviews',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(),
            Expanded(
              child: widget.shop.reviews.isEmpty
                  ? const Center(child: Text('No reviews yet.'))
                  : ListView.builder(
                      itemCount: widget.shop.reviews.length,
                      itemBuilder: (context, index) {
                        final review = widget.shop.reviews[index];
                        return ListTile(
                          title: Text(review.reviewer),
                          subtitle: Text(review.comment),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(review.rating.toString()),
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _reviewController,
                    decoration: const InputDecoration(
                      labelText: 'Write a review...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _ratingController,
                    decoration: const InputDecoration(
                      labelText: 'Rating (1-5)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _addReview,
                    child: const Text('Submit Review'),
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
