import 'package:flutter/material.dart';
import 'package:guess_number/data/dataManager.dart';

class IhmOptions extends StatefulWidget {
  IhmOptions({Key key, this.title}) : super(key: key);
  final String title;

  _IhmOptionsState createState() => _IhmOptionsState();
}

class _IhmOptionsState extends State<IhmOptions> {
  final ctrlMin = TextEditingController();
  final ctrlMax = TextEditingController();
  final DataManger _dataManger = DataManger.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Options"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Valeur minimale : "),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: TextField(
                    controller: ctrlMin,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(),
                    onSubmitted: (value) {
                      _trySaveValues();
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Valeur maximale : "),
                Container(
                  width: MediaQuery.of(context).size.width * 0.40,
                  child: TextField(
                    controller: ctrlMax,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(),
                    onSubmitted: (value) {
                      _trySaveValues();
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            FlatButton(
              onPressed: _acceptAndClose,
              child: Text(
                'Accepter et revenir au jeu',
              ),
              color: Colors.green,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tryLoadValues();
  }

  void _trySaveValues() {
    var min = 1;
    try {
      min = int.parse(ctrlMin.text);
    } catch (e) {
      _raiseError(e);
    }

    var max = 100;
    try {
      max = int.parse(ctrlMax.text);
    } catch (e) {
      _raiseError(e);
    }

    _dataManger.saveValues(min: min, max: max);
  }

  void _tryLoadValues() async {
    var minMaxValues = await _dataManger.loadValues();
    ctrlMin.text = minMaxValues[0].toString();
    ctrlMax.text = minMaxValues[1].toString();
  }

  void _raiseError(String errorMessage) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text(
                "Une erreur a été rencontré : la donnée que vous avez tenté d'enrégistrer n'est pas un nombre. Veuillez rentrer un nombre svp."),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  void _acceptAndClose() {
    Navigator.pop(context);
  }
}
