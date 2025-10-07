import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/configuration_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = context.watch<ConfigurationData>();
    final currentSize = config.size;

    final List<int> sizeOptions = [8, 16, 18, 20, 24, 32];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tamaño del pixel art',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: currentSize,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: sizeOptions
                  .map((size) => DropdownMenuItem<int>(
                        value: size,
                        child: Text('$size px'),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  context.read<ConfigurationData>().setSize(value);
                }
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Configuración de paleta de colores',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Paleta de colores (mock)
            Wrap(
              spacing: 8,
              children: List.generate(
                6,
                (index) => CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Colors.primaries[index * 2], // ej
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Mock Paleta Colores'),
          ],
        ),
      ),
    );
  }
}
