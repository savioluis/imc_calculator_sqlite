import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferencesService._();
  static final _instance = SharedPreferencesService._();

  factory SharedPreferencesService() {
    return _instance;
  }

  static SharedPreferences? _preferences;

  static const String _keyNome = "nome";
  static const String _keyAltura = "altura";

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> setNome(String nome) async {
    await _preferences!.setString(_keyNome, nome);
  }

  static Future<String?> getNome() async {
    return _preferences!.getString(_keyNome);
  }

  static Future<void> setAltura(double altura) async {
    await _preferences!.setDouble(_keyAltura, altura);
  }

  static Future<double?> getAltura() async {
    return _preferences!.getDouble(_keyAltura);
  }
}
