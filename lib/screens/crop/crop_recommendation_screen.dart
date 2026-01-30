import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../models/crop_recommendation_model.dart';

class CropRecommendationScreen extends StatefulWidget {
  const CropRecommendationScreen({super.key});

  @override
  State<CropRecommendationScreen> createState() =>
      _CropRecommendationScreenState();
}

class _CropRecommendationScreenState extends State<CropRecommendationScreen> {
  final List<CropRecommendationModel> _recommendations = [
    CropRecommendationModel(
      cropName: 'Tomato',
      cropType: 'Vegetable',
      expectedYield: 15.5,
      expectedPrice: 25.0,
      expectedProfit: 387500.0,
      growthDuration: 90,
      season: 'Kharif',
      waterRequirement: 500.0,
      riskScore: 35.0,
      soilType: 'Red Loamy',
      benefits: [
        'High market demand',
        'Multiple harvest cycles',
        'Good profit margin',
        'Established supply chain'
      ],
      challenges: [
        'Disease susceptible',
        'Requires regular monitoring',
        'Weather sensitive'
      ],
      marketDemand: 85.0,
    ),
    CropRecommendationModel(
      cropName: 'Chili',
      cropType: 'Spice',
      expectedYield: 8.2,
      expectedPrice: 80.0,
      expectedProfit: 656000.0,
      growthDuration: 120,
      season: 'Rabi',
      waterRequirement: 400.0,
      riskScore: 45.0,
      soilType: 'Red Loamy',
      benefits: [
        'Premium export pricing',
        'High demand in spice market',
        'Long storage life',
        'Value addition opportunities'
      ],
      challenges: [
        'Pest management critical',
        'Price volatility',
        'Extended growth period'
      ],
      marketDemand: 78.0,
    ),
    CropRecommendationModel(
      cropName: 'Onion',
      cropType: 'Vegetable',
      expectedYield: 12.0,
      expectedPrice: 20.0,
      expectedProfit: 240000.0,
      growthDuration: 150,
      season: 'Rabi',
      waterRequirement: 350.0,
      riskScore: 50.0,
      soilType: 'Black Cotton',
      benefits: [
        'Stable market',
        'Good storage options',
        'Multiple varieties',
        'Government support'
      ],
      challenges: [
        'Market price fluctuations',
        'Storage costs',
        'Longer growth cycle'
      ],
      marketDemand: 72.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Recommendations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppColors.primaryGreen.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb, color: AppColors.primaryGreen),
                        SizedBox(width: 10),
                        Text(
                          'AI Recommendations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Based on your soil type, weather, and market trends',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Top Crops for Your Farm',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 15),
            ..._recommendations.map((crop) => _buildCropCard(crop)),
          ],
        ),
      ),
    );
  }

  Widget _buildCropCard(CropRecommendationModel crop) {
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
                        crop.cropName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        crop.cropType,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getRiskColor(crop.riskScore).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getRiskLevel(crop.riskScore),
                    style: TextStyle(
                      color: _getRiskColor(crop.riskScore),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(
                  'Yield',
                  '${crop.expectedYield} tons/acre',
                  Icons.agriculture,
                ),
                _buildMetric(
                  'Profit',
                  '₹${(crop.expectedProfit / 1000).toStringAsFixed(0)}K',
                  Icons.currency_rupee,
                ),
                _buildMetric(
                  'Duration',
                  '${crop.growthDuration} days',
                  Icons.calendar_today,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildInfoChip(
                    'Season: ${crop.season}',
                    Icons.wb_sunny,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInfoChip(
                    'Demand: ${crop.marketDemand.toStringAsFixed(0)}%',
                    Icons.trending_up,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ExpansionTile(
              title: const Text('View Details'),
              tilePadding: EdgeInsets.zero,
              childrenPadding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDetailSection('Benefits', crop.benefits, Colors.green),
                const SizedBox(height: 15),
                _buildDetailSection('Challenges', crop.challenges, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryGreen, size: 24),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, size: 6, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Color _getRiskColor(double riskScore) {
    if (riskScore < 40) return Colors.green;
    if (riskScore < 60) return Colors.orange;
    return Colors.red;
  }

  String _getRiskLevel(double riskScore) {
    if (riskScore < 40) return 'Low Risk';
    if (riskScore < 60) return 'Medium Risk';
    return 'High Risk';
  }
}
