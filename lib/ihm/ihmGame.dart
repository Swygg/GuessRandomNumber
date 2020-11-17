import 'package:flutter/material.dart';
import 'package:guess_number/BLL/Calculateur.dart';
import 'package:guess_number/EResult.dart';
import 'package:guess_number/ihm/ihmOptions.dart';
//import 'package:guess_number/nagivatorFile.dart';

class IhmGame extends StatefulWidget {
  IhmGame({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _IhmGameState createState() => _IhmGameState();
}

class _IhmGameState extends State<IhmGame> {
  Calculateur calculateur = Calculateur();
  String _answer;
  FocusNode myFocusNode;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: startNewGame,
            color: Colors.white,
            iconSize: 30,
          ),
          IconButton(
            icon: Icon(Icons.build),
            onPressed: _openOptions,
            color: Colors.white,
            iconSize: 25,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getScreen(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startNewGame();
    myFocusNode = FocusNode();
  }

  void startNewGame() {
    calculateur.createNewMysteryNumber();
    setState(() {
      _answer = null;
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  void compare(String val) {
    var result = calculateur.compare(strNumber: val);
    _answer = getResult(result);
    myFocusNode.requestFocus();
    myController.text = "";
    setState(() {});
  }

  String getResult(EResult result) {
    var answer = "";
    switch (result) {
      case EResult.GoodNumber:
        answer =
            "Bien joué ! Vous avez trouvé le bon nombre en ${calculateur.getNbTry()} coup(s)";
        break;
      case EResult.Highter:
        answer = "Plus haut que ${myController.text}";
        break;
      case EResult.Lower:
        answer = "Plus bas que ${myController.text}";
        break;
      case EResult.TooHight:
        answer = "Vous avez écris un nombre supérieur au maximum";
        break;
      case EResult.TooLow:
        answer = "Vous avez écris un nombre inférieur au minimum";
        break;
      default:
        answer = "Rien trouvé...";
        break;
    }
    return answer;
  }

  List<Widget> getScreen() {
    List<Widget> maListe = List();
    if (calculateur.isWin) {
      maListe.add(Text(
        'VICTORE !',
      ));
      maListe.add(Text(
        'Le nombre magique était ${calculateur.nbMagic}.',
      ));
      maListe.add(Text(
        'Il vous a fallut ${calculateur.getNbTry()} essai(s).',
      ));
      maListe.add(Image.asset("assets/pictures/metalhand.png"));
      maListe.add(RaisedButton(
        onPressed: startNewGame,
        child: Text(
          'Lancer un nouveau jeu !',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.red,
        elevation: 8,
      ));
    } else {
      maListe.add(Text(
        'Veuillez deviner le nombre magique, compris entre :',
      ));
      maListe.add(Text(
        '${calculateur.min} et ${calculateur.max}'// (${calculateur.nbMagic})',
      ));
      maListe.add(Divider());
      maListe.add(TextField(
        keyboardType: TextInputType.number,
        autofocus: true,
        focusNode: myFocusNode,
        controller: myController,
        decoration: InputDecoration(
          hintText: 'Saisissez un nombre !',
        ),
        onSubmitted: (value) {
          setState(() {
            compare(value);
          });
        },
      ));
      maListe.add(Text(
        _answer == null ? '' : _answer,
      ));
    }
    return maListe;
  }

  void _openOptions() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => IhmOptions(title: "???")));
  }
}
