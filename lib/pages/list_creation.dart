import 'package:flutter/material.dart';

class CreationListScreen extends StatelessWidget {
  const CreationListScreen({super.key});

  final List<Map<String, String>> creations = const [
    {
      'title': 'Ají',
      'image': 'assets/Pixel-Art-Hot-Pepper-2-1.webp',
    },
    {
      'title': 'Pizza',
      'image': 'assets/Pixel-Art-Pizza-2.webp',
    },
    {
      'title': 'Sandía',
      'image': 'assets/Pixel-Art-Watermelon-3.webp',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creaciones Realizadas'),
      ),
      body: ListView.builder(
        itemCount: creations.length,
        itemBuilder: (context, index) {
          final creation = creations[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.asset(
                creation['image']!,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 48),
              ),
              title: Text(
                creation['title']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Abriste: ${creation['title']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
