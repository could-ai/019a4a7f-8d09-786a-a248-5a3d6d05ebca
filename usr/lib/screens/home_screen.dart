import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/shop.dart';
import 'package:couldai_user_app/screens/shop_detail_screen.dart';
import 'package:couldai_user_app/widgets/shop_card.dart';
import 'package:couldai_user_app/screens/create_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy data for shops, now with status
  List<Shop> _shops = [
    Shop(id: '1', name: 'Sharma General Store', description: 'Your everyday needs store', rating: 4.5, reviews: [Review(reviewer: 'Rahul', comment: 'Great products!', rating: 5)], status: 'approved'),
    Shop(id: '2', name: 'Gupta Electronics', description: 'All electronic gadgets available', rating: 4.2, reviews: [Review(reviewer: 'Priya', comment: 'Found what I was looking for.', rating: 4)], status: 'approved'),
    Shop(id: '3', name: 'Verma Book Depot', description: 'A wide range of books', rating: 4.8, reviews: [Review(reviewer: 'Amit', comment: 'Excellent collection of books.', rating: 5)], status: 'approved'),
    Shop(id: '4', name: 'Sanjay Mobiles', description: 'Latest smartphones and accessories', rating: 4.0, reviews: [], status: 'pending'),
    Shop(id: '5', name: 'Prakash Bakery', description: 'Fresh cakes and pastries', rating: 4.7, reviews: [], status: 'rejected'),
  ];

  List<Shop> _filteredShops = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredShops = _shops;
    _searchController.addListener(_filterShops);
  }

  void _filterShops() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredShops = _shops.where((shop) {
        return shop.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addShop(Shop newShop) {
    setState(() {
      _shops.add(newShop);
      _filteredShops = _shops;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search for shops',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _filteredShops.isEmpty
                  ? const Center(child: Text('No shops found'))
                  : ListView.builder(
                      itemCount: _filteredShops.length,
                      itemBuilder: (context, index) {
                        final shop = _filteredShops[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopDetailScreen(shop: shop),
                              ),
                            );
                          },
                          child: ShopCard(shop: shop),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProfileScreen(onAddShop: _addShop),
            ),
          );
        },
        tooltip: 'Create Profile',
        child: const Icon(Icons.add),
      ),
    );
  }
}