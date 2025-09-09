import 'package:flutter/material.dart';
import 'package:lab_2/pages/list_art.dart';
import 'package:lab_2/pages/about.dart';
import 'package:lab_2/pages/list_creation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Art Studio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pixel Art Studio'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final int _defaultCounter = 0;

  final Color _color1 = Colors.amberAccent;
  final Color _color2 = Colors.grey;

  Color _currentColor = Colors.amberAccent;

  void _incrementCounter() => setState(() => _counter++);
  void _decrementCounter() => setState(() => _counter--);
  void _presetCounter() => setState(() => _counter = _defaultCounter);
  void _changeColor() => setState(() {
        _currentColor = _currentColor == _color1 ? _color2 : _color1;
      });

  @override
  Widget build(BuildContext context) {
    final persistentFooterButtons = [
      FloatingActionButton(
        onPressed: _decrementCounter,
        backgroundColor: _currentColor,
        tooltip: 'Decrement',
        child: const Icon(Icons.remove),
      ),
      FloatingActionButton(
        onPressed: _presetCounter,
        backgroundColor: _currentColor,
        tooltip: 'Default',
        child: const Icon(Icons.exposure_zero),
      ),
      FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _currentColor,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      FloatingActionButton(
        onPressed: _changeColor,
        backgroundColor: _currentColor,
        tooltip: 'ChangeColor',
        child: const Icon(Icons.palette),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pixel Art sobre una grilla personalizable',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      tooltip: 'About',
                      icon: const Icon(Icons.info_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/Pixel-Art-Pizza-2.webp',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.black12,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'Contador:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$_counter',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      _AssetThumb('assets/Pixel-Art-Hot-Pepper-2-1.webp', 'Ají'),
                      _AssetThumb('assets/Pixel-Art-Pizza-2.webp', 'Pizza'),
                      _AssetThumb(
                          'assets/Pixel-Art-Watermelon-3.webp', 'Sandía'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Botones de acción: Crear y Compartir
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListArtScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.brush),
                        label: const Text('Crear'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Compartir: aún no implementado'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Compartir'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreationListScreen()),
                      );
                    },
                    icon: const Icon(Icons.collections),
                    label: const Text('Mis creaciones'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}

class _AssetThumb extends StatelessWidget {
  const _AssetThumb(this.path, this.label);
  final String path;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Image.asset(
            path,
            width: 96,
            height: 96,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 96),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
