import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/home_page.dart';

// Librerías de persistencia
import 'providers/configuration_data.dart';
import 'services/shared_preferences_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    logger.d("Logger está dando cara!");

    return ChangeNotifierProvider<ConfigurationData>(
      // Inicializa el provider con el servicio de SharedPreferences
      create: (_) => ConfigurationData(SharedPreferencesService()),
      child: MaterialApp(
        title: '2023479014',
        theme: _buildAppTheme(),
        home: const MyHomePage(title: '2023479014'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Configuración del tema con Google Fonts y Material 3
ThemeData _buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 129, 26, 189),
      brightness: Brightness.dark,
    ),
  );

  final textThemeBody = GoogleFonts.robotoTextTheme(base.textTheme);

  return base.copyWith(
    textTheme: textThemeBody,
    appBarTheme: AppBarTheme(
      backgroundColor: base.colorScheme.inversePrimary,
      foregroundColor: base.colorScheme.onPrimaryContainer,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textThemeBody.titleLarge?.copyWith(fontWeight: FontWeight.w700),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: base.colorScheme.primary,
      foregroundColor: base.colorScheme.onPrimary,
      shape: const StadiumBorder(),
      elevation: 2,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: base.colorScheme.surfaceContainerHighest,
    ),
  );
}
