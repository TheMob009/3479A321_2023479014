import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

import '../providers/configuration_data.dart';

class PixelArtScreen extends StatefulWidget {
  const PixelArtScreen({Key? key}) : super(key: key);

  @override
  _PixelArtScreenState createState() => _PixelArtScreenState();
}

class _PixelArtScreenState extends State<PixelArtScreen> {
  late int _sizeGrid;
  final logger = Logger();

  final List<int> sizeOptions = [8, 16, 18, 20, 24, 32];

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<ConfigurationData>().size;
    logger.d("initState: Tamaño actual para el pixel art: $_sizeGrid");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d("Dependencias cargadas");
  }

  @override
  void didUpdateWidget(covariant PixelArtScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.d("Widget actualizado");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.d("Hotreload aplicado");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.d("Desmontando widget");
  }

  @override
  void dispose() {
    logger.d("Widget destruido");
    super.dispose();
  }

  void _updateStateExample() {
    setState(() {
      _sizeGrid = context.read<ConfigurationData>().size;
      logger.d("Estado modificado manualmente -> sizeGrid=$_sizeGrid");
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build: Construyendo UI con sizeGrid=$_sizeGrid");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Art Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _sizeGrid,
              decoration: const InputDecoration(
                labelText: 'Seleccionar tamaño',
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
                  setState(() => _sizeGrid = value);
                  logger.d("Se actualizo el dropdown, nuevo tamaño = $value");
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _updateStateExample,
              child: Text('Actualizar tamaño de pixel: $_sizeGrid'),
            ),
          ],
        ),
      ),
    );
  }
}
