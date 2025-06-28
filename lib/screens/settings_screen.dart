import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/shared_preferences.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currentTheme = 'light';
  double _currentFontSize = 16.0;
  String _currentFontFamily = 'Roboto';
  final List<String> _fontOptions = ['Roboto', 'Courier New'];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    String theme = await SharedPrefsService.getTheme();
    double fontSize = await SharedPrefsService.getFontSize();
    String fontFamily = await SharedPrefsService.getFontFamily();

    // Validar que fontFamily esté en _fontOptions
    if (!_fontOptions.contains(fontFamily)) {
      fontFamily = _fontOptions.first;
    }

    setState(() {
      _currentTheme = theme;
      _currentFontSize = fontSize;
      _currentFontFamily = fontFamily;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Tema de la app'),
            contentPadding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
            subtitle: Text(
              _currentTheme == 'light' ? 'Tema claro' : 'Tema oscuro',
            ),
            trailing: DropdownButton<String>(
              value: _currentTheme,
              items: const [
                DropdownMenuItem(value: 'light', child: Text('Claro')),
                DropdownMenuItem(value: 'dark', child: Text('Oscuro')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _currentTheme = value;
                  });
                  themeProvider.toggleTheme(value);
                }
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Tamaño de texto'),
            contentPadding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
            subtitle: Text(_currentFontSize.toStringAsFixed(1)),
            trailing: SizedBox(
              width: 180,
              child: Slider(
                value: _currentFontSize,
                min: 12.0,
                max: 24.0,
                divisions: 6,
                label: _currentFontSize.round().toString(),
                onChanged: (value) {
                  setState(() => _currentFontSize = value);
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setFontSize(value);
                  SharedPrefsService.setFontSize(value);
                },
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Tipo de fuente'),
            subtitle: Text(_currentFontFamily),
            trailing: DropdownButton<String>(
              value: _currentFontFamily,
              items: _fontOptions
                  .map(
                    (font) => DropdownMenuItem(value: font, child: Text(font)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _currentFontFamily = value);
                  Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setFontFamily(value.toString());
                  SharedPrefsService.setFontFamily(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
