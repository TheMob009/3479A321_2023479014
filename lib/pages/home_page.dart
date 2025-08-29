import 'package:flutter/material.dart';

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
        // Toma estilos desde AppBarTheme del tema global
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Pixel Art sobre una grilla personalizable'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            // Fila scrolleable con imágenes de assets
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  _AssetThumb('assets/Pixel-Art-Hot-Pepper-2-1.webp', 'Ají'),
                  _AssetThumb('assets/Pixel-Art-Pizza-2.webp', 'Pizza'),
                  _AssetThumb('assets/Pixel-Art-Watermelon-3.webp', 'Sandía'),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: persistentFooterButtons,
    );
  }
}

// Para no repetir codigoo
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
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 96),
          ),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
    }
}
