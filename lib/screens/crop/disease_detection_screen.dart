import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/app_theme.dart';
import '../../models/crop_disease_model.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});

  @override
  State<DiseaseDetectionScreen> createState() => _DiseaseDetectionScreenState();
}

class _DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  final ImagePicker _picker = ImagePicker();
  CropDiseaseModel? _detectionResult;
  bool _isAnalyzing = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _isAnalyzing = true;
        });

        // Simulate AI analysis
        await Future.delayed(const Duration(seconds: 2));

        setState(() {
          _detectionResult = CropDiseaseModel(
            id: 'detection_${DateTime.now().millisecondsSinceEpoch}',
            cropName: 'Tomato',
            diseaseName: 'Early Blight',
            confidence: 89.5,
            severity: 'medium',
            description:
                'Early blight is a common tomato disease caused by the fungus Alternaria solani. It affects leaves, stems, and fruits.',
            symptoms: [
              'Dark brown spots with concentric rings on leaves',
              'Yellowing of older leaves',
              'Premature leaf drop',
              'Reduced fruit quality'
            ],
            treatments: [
              'Remove and destroy infected leaves',
              'Apply copper-based fungicides',
              'Improve air circulation',
              'Water at the base of plants',
              'Rotate crops yearly'
            ],
            detectedAt: DateTime.now(),
          );
          _isAnalyzing = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error picking image: $e');
      }
      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Disease Detection'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 64,
                      color: AppColors.primaryGreen,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Scan Your Crop',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Take a photo of affected leaves for instant AI diagnosis',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          icon: const Icon(Icons.camera),
                          label: const Text('Camera'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isAnalyzing) ...[
              const SizedBox(height: 20),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Analyzing crop image...'),
                    ],
                  ),
                ),
              ),
            ],
            if (_detectionResult != null && !_isAnalyzing) ...[
              const SizedBox(height: 20),
              _buildResultCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    if (_detectionResult == null) return const SizedBox();

    final result = _detectionResult!;
    final severityColor = _getSeverityColor(result.severity);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.bug_report,
                    color: severityColor,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.diseaseName,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: severityColor,
                                ),
                      ),
                      Text(
                        '${result.confidence.toStringAsFixed(1)}% confidence',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSection('Description', result.description),
            const SizedBox(height: 15),
            _buildListSection('Symptoms', result.symptoms),
            const SizedBox(height: 15),
            _buildListSection('Treatments', result.treatments),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      case 'low':
        return AppColors.success;
      default:
        return Colors.grey;
    }
  }
}
