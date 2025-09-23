import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';
import 'l10n/app_localizations.dart';
import 'themes/app_theme.dart';
import 'providers/theme_provider.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // API-Service initialisieren
  ApiService().initialize(
    baseUrl: 'https://your-api.example.com/api/v1', // TODO: Echte API-URL einsetzen
    timeout: const Duration(seconds: 30),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  );
  
  // Gespeicherte Auth-Token laden
  await AuthService().loadTokensFromStorage();
  
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'Terminal One',
          
          // Theme configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeProvider.themeMode,
          
          // Localization configuration
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('de'), // German
            Locale('fr'), // French
            Locale('it'), // Italian
            Locale('pt'), // Portuguese
            Locale('af'), // Afrikaans
          ],
          
          home: HomeScreen(
            codeLength: 6, // Configure code length here (4-12 digits supported)
            themeProvider: _themeProvider, // Pass theme provider to home screen
          ),
        );
      },
    );
  }
}
