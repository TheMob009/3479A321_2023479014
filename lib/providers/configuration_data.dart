import 'package:flutter/material.dart';
import '../services/shared_preferences_service.dart';

class ConfigurationData extends ChangeNotifier {
  final SharedPreferencesService _prefsService;

  bool _isResetEnabled = false;
  int _size = 16;

  // 🔹 NUEVO: estado para mostrar/ocultar números en la grilla
  bool _showCellNumbers = true;

  ConfigurationData(this._prefsService) {
    _loadPreferences();
  }

  bool get isResetEnabled => _isResetEnabled;
  int get size => _size;
  // 🔹 NUEVO: getter público
  bool get showCellNumbers => _showCellNumbers;

  Future<void> _loadPreferences() async {
    _isResetEnabled = await _prefsService.getIsResetEnabled();
    _size = await _prefsService.getGridSize();
    // 🔹 NUEVO: cargar preferencia persistida
    _showCellNumbers = await _prefsService.getShowCellNumbers();
    notifyListeners();
  }

  Future<void> updateResetEnabled(bool value) async {
    _isResetEnabled = value;
    await _prefsService.setIsResetEnabled(value);
    notifyListeners();
  }

  Future<void> updateGridSize(int value) async {
    _size = value;
    await _prefsService.setGridSize(value);
    notifyListeners();
  }

  // 🔹 NUEVO: actualizar/persistir el toggle de números
  Future<void> updateShowCellNumbers(bool value) async {
    _showCellNumbers = value;
    await _prefsService.setShowCellNumbers(value);
    notifyListeners();
  }

  void setSize(int newSize) {
    if (_size != newSize) {
      _size = newSize;
      notifyListeners();
    }
  }
}
