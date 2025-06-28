// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/shared_preferences.dart';
import 'theme/theme_provider.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'SP Act 2',
            theme: AppTheme.lightTheme(
              fontSize: themeProvider.fontSize,
              fontFamily: themeProvider.fontFamily,
            ),
            darkTheme: AppTheme.darkTheme(
              fontSize: themeProvider.fontSize,
              fontFamily: themeProvider.fontFamily,
            ),
            themeMode: themeProvider.themeMode,
            home: FutureBuilder<bool>(
              future: SharedPrefsService.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }

                // Si está logeado, ir al home, sino al login
                return snapshot.data == true ? HomeScreen() : LoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
