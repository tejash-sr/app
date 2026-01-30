import 'package:flutter/material.dart';

class FarmManagementScreen extends StatelessWidget {
  const FarmManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farm Management')),
      body: const Center(child: Text('Farm Management Module')),
    );
  }
}
