import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/app_theme.dart';
import '../../models/price_forecast_model.dart';

class PriceForecastScreen extends StatelessWidget {
  const PriceForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast = PriceForecastModel(
      cropName: 'Tomato',
      currentPrice: 25.0,
      predictedPrice30Days: 32.0,
      predictedPrice60Days: 38.0,
      predictedPrice90Days: 35.0,
      trend: 'rising',
      confidence: 78.5,
      bestSellDate: '45 days from now',
      historicalPrices: List.generate(
        30,
        (i) => PriceDataPoint(
          date: DateTime.now().subtract(Duration(days: 30 - i)).toString().split(' ')[0],
          price: 20.0 + (i * 0.5) + (i % 3 * 2),
        ),
      ),
      forecastedPrices: List.generate(
        90,
        (i) => PriceDataPoint(
          date: DateTime.now().add(Duration(days: i)).toString().split(' ')[0],
          price: 25.0 + (i * 0.15) + (i % 5 * 1.5),
        ),
      ),
      marketAnalysis:
          'Tomato prices are expected to rise due to increased demand and reduced supply in the market. Optimal selling window is in 45-60 days.',
      timestamp: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Price Forecast')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          forecast.cropName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                forecast.trend == 'rising' ? Icons.trending_up : Icons.trending_down,
                                color: AppColors.success,
                                size: 16,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                forecast.trend.toUpperCase(),
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPriceInfo('Current', forecast.currentPrice),
                        _buildPriceInfo('30 Days', forecast.predictedPrice30Days),
                        _buildPriceInfo('60 Days', forecast.predictedPrice60Days),
                        _buildPriceInfo('90 Days', forecast.predictedPrice90Days),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Trend',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(
                                15,
                                (i) => FlSpot(i.toDouble(), 20 + i.toDouble() + (i % 3 * 2)),
                              ),
                              isCurved: true,
                              color: AppColors.primaryGreen,
                              barWidth: 3,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: AppColors.primaryGreen.withValues(alpha: 0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: AppColors.success.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.recommend, color: AppColors.success),
                        SizedBox(width: 10),
                        Text(
                          'Best Sell Time',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      forecast.bestSellDate,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      forecast.marketAnalysis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo(String label, double price) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          '₹${price.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
