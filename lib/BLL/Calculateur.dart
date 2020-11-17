import 'dart:math';
import 'package:guess_number/EResult.dart';
import 'package:guess_number/data/dataManager.dart';

class Calculateur {
  int _min;
  int _max;
  int _mysteryNumber;
  int _nbTry;
  bool _isWin;
  final DataManger _dataManger = DataManger.getInstance();

  calculeur() {
    createNewMysteryNumber();
  }

  int get min {
    return _min;
  }

  int get max {
    return _max;
  }

  int get nbMagic {
    return _mysteryNumber;
  }

  bool get isWin {
    return _isWin;
  }

  void createNewMysteryNumber({int min, int max}) async {
    _nbTry = 0;
    _isWin = false;

    var minMax = await _dataManger.loadValues();

    _min = min != null ? min : minMax[0];
    _max = max != null ? max : minMax[1];

    var random = Random();
    _mysteryNumber = _min + random.nextInt(_max - _min);
  }

  EResult compare({int number, String strNumber}) {
    if (number == null && strNumber == null) return EResult.Error;
    if (number == null && strNumber != null) {
      try {
        number = int.parse(strNumber);
      } catch (exception) {
        return EResult.Error;
      }
    }

    if (number < _min)
      return EResult.TooLow;
    else if (number > _max)
      return EResult.TooHight;
    else if (number == _mysteryNumber) {
      _nbTry++;
      _isWin = true;
      return EResult.GoodNumber;
    } else if (number < _mysteryNumber) {
      _nbTry++;
      if (number > _min) {
        _min = number;
      }
      return EResult.Highter;
    } else if (number > _mysteryNumber) {
      _nbTry++;
      if (number < _max) {
        _max = number;
      }
      return EResult.Lower;
    } else
      return EResult.Error;
  }

  int getNbTry() {
    if (_isWin)
      return _nbTry;
    else
      return -1;
  }
}
