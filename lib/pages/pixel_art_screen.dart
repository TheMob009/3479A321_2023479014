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
  final Logger logger = Logger();
  int _sizeGrid = 16;
  Color _selectedColor = Colors.black;

  final List<Color> _listColors = const [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.pink,
  ];

  // Mantiene el color de cada celda
  late List<Color> _cellColors;

  final List<int> sizeOptions = const [8, 16, 18, 20, 24, 32];

  @override
  void initState() {
    super.initState();
    _sizeGrid = context.read<ConfigurationData>().size;
    _cellColors = List<Color>.generate(_sizeGrid * _sizeGrid, (_) => Colors.transparent);
    logger.d("initState: Tamaño inicial = $_sizeGrid");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Si cambia el tamaño en Provider, recrea la grilla
    final newSize = context.watch<ConfigurationData>().size;
    if (_sizeGrid != newSize) {
      setState(() {
        _sizeGrid = newSize;
        _cellColors = List<Color>.generate(_sizeGrid * _sizeGrid, (_) => Colors.transparent);
      });
      logger.d("didChangeDependencies: Tamaño actualizado a $_sizeGrid");
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.d("build: Construyendo con tamaño $_sizeGrid");

    // 🔹 Leemos el estado del toggle desde Provider
    final showNumbers = context.watch<ConfigurationData>().showCellNumbers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixel Art'),
        actions: [
          // 🔹 Toggle en el extremo derecho del AppBar
          Tooltip(
            message: showNumbers ? 'Ocultar números' : 'Mostrar números',
            child: Switch.adaptive(
              value: showNumbers,
              onChanged: (value) {
                // Actualiza Provider y persiste en SharedPreferences
                context.read<ConfigurationData>().updateShowCellNumbers(value);
                // No es necesario setState aquí porque Provider notifica a los listeners
                logger.d("Toggle números -> $value");
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Selector de tamaño de grilla
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<int>(
                value: _sizeGrid,
                decoration: const InputDecoration(
                  labelText: 'Seleccionar tamaño de grilla',
                  border: OutlineInputBorder(),
                ),
                items: sizeOptions
                    .map((size) => DropdownMenuItem<int>(
                          value: size,
                          child: Text('$size x $size'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null && value != _sizeGrid) {
                    // Persiste el tamaño en Provider + SharedPreferences
                    context.read<ConfigurationData>().updateGridSize(value);
                    setState(() {
                      _sizeGrid = value;
                      _cellColors = List<Color>.generate(_sizeGrid * _sizeGrid, (_) => Colors.transparent);
                    });
                    logger.d("Nuevo tamaño seleccionado: $_sizeGrid");
                  }
                },
              ),
            ),
            const SizedBox(height: 12),

            // Grilla de celdas
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _sizeGrid,
                ),
                itemCount: _sizeGrid * _sizeGrid,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _cellColors[index] = _selectedColor;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      color: _cellColors[index],
                      // 🔹 Si showNumbers es true, mostramos el índice; si no, no mostramos nada
                      child: showNumbers
                          ? Center(
                              child: Text(
                                '$index',
                                style: TextStyle(
                                  color: _cellColors[index] == Colors.black
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),

            // Paleta de colores
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _listColors.map((color) {
                    final bool isSelected = color == _selectedColor;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 2)
                              : null,
                        ),
                        width: isSelected ? 36 : 28,
                        height: isSelected ? 36 : 28,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
