import 'package:flutter/material.dart';

class ConfigurationData extends ChangeNotifier {
  int _size = 8; // Tamaño por defecto

  int get size => _size;

  void setSize(int newSize) {
    if (_size != newSize) {
      _size = newSize;
      notifyListeners(); // Notifica a los widgets que dependen de esta data
    }
  }
}
