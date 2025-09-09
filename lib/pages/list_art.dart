import 'package:flutter/material.dart';

class ListArtScreen extends StatelessWidget {
  const ListArtScreen({super.key});

  final List<String> pixelArts = const [
    'Ají',
    'Pizza',
    'Sandía',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pixel Art'),
      ),
      body: ListView.builder(
        itemCount: pixelArts.length,
        itemBuilder: (context, index) {
          final artName = pixelArts[index];
          return ListTile(
            leading: const Icon(Icons.image, color: Colors.indigo),
            title: Text(
              artName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Seleccionaste: $artName')),
              );
            },
          );
        },
      ),
    );
  }
}
