import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _keyIsResetEnabled = 'isResetEnabled';
  static const String _keyGridSize = 'gridSize';
  // 🔹 NUEVO: preferencia para mostrar/ocultar números de las celdas
  static const String _keyShowCellNumbers = 'showCellNumbers';

  Future<bool> getIsResetEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsResetEnabled) ?? false;
  }

  Future<void> setIsResetEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsResetEnabled, value);
  }

  Future<int> getGridSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyGridSize) ?? 16;
  }

  Future<void> setGridSize(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyGridSize, value);
  }

  // 🔹 NUEVO: getters/setters para showCellNumbers (por defecto: true)
  Future<bool> getShowCellNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyShowCellNumbers) ?? true;
  }

  Future<void> setShowCellNumbers(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyShowCellNumbers, value);
  }
}
