import 'package:shared_preferences/shared_preferences.dart';

class DataManger {
  // ignore: unused_element
  _dataManager() {}

  static DataManger _instance;
  static DataManger getInstance() {
    if (_instance == null) _instance = DataManger();
    return _instance;
  }

  static String _keyMin = "min";
  static String _keyMax = "max";

  Future<SharedPreferences> _preference = SharedPreferences.getInstance();

  void saveValues({int min, int max}) async {
    if (min == null) min = 1;
    if (max == null) max = 100;
    final SharedPreferences prefs = await _preference;
    prefs.setInt(_keyMin, min);
    prefs.setInt(_keyMax, max);
  }

  Future<List<int>> loadValues() async {
    final SharedPreferences prefs = await _preference;
    var min = 1;
    if (prefs.getInt(_keyMin) != null) {
      min = prefs.getInt(_keyMin);
    }
    var max = 100;
    if (prefs.getInt(_keyMax) != null) {
      max = prefs.getInt(_keyMax);
    }
    return [min, max];
  }
}
