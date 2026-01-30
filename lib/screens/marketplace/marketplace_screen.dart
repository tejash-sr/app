import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../models/marketplace_listing_model.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listings = [
      MarketplaceListingModel(
        id: 'listing_001',
        sellerId: 'farmer_001',
        sellerName: 'Ravi Kumar',
        cropName: 'Tomato',
        cropType: 'Vegetable',
        quantity: 500.0,
        pricePerKg: 25.0,
        quality: 'Premium',
        location: 'Bangalore Rural, Karnataka',
        images: [],
        description: 'Fresh organic tomatoes, ready for immediate delivery',
        harvestDate: DateTime.now().subtract(const Duration(days: 2)),
        listedAt: DateTime.now().subtract(const Duration(hours: 5)),
        status: 'available',
        rating: 4.5,
      ),
      MarketplaceListingModel(
        id: 'listing_002',
        sellerId: 'farmer_002',
        sellerName: 'Suresh Patel',
        cropName: 'Onion',
        cropType: 'Vegetable',
        quantity: 1000.0,
        pricePerKg: 18.0,
        quality: 'Good',
        location: 'Pune, Maharashtra',
        images: [],
        description: 'Quality onions, bulk orders welcome',
        harvestDate: DateTime.now().subtract(const Duration(days: 5)),
        listedAt: DateTime.now().subtract(const Duration(days: 1)),
        status: 'available',
        rating: 4.8,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new listing
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listings.length,
        itemBuilder: (context, index) {
          return _buildListingCard(context, listings[index]);
        },
      ),
    );
  }

  Widget _buildListingCard(BuildContext context, MarketplaceListingModel listing) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listing.cropName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        listing.cropType,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    listing.quality,
                    style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(listing.description),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16),
                const SizedBox(width: 5),
                Text(listing.sellerName),
                const SizedBox(width: 15),
                const Icon(Icons.location_on_outlined, size: 16),
                const SizedBox(width: 5),
                Expanded(child: Text(listing.location, overflow: TextOverflow.ellipsis)),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Price per kg', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(
                      '₹${listing.pricePerKg.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Available', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(
                      '${listing.quantity} kg',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Place bid or buy
                  },
                  child: const Text('Contact'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
