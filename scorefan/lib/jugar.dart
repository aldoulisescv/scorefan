import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/variables.dart';

class Jugar extends StatefulWidget {
  @override
  _JugarState createState() => _JugarState();
}

class _JugarState extends State<Jugar> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  List<bool> _selected = List.generate(20, (i) => false);
  Widget _leadingIcon(){
    return IconButton(
            icon: const Icon(Icons.menu),
            color: Variables.AZULOSCURO,
            iconSize: 40,
            onPressed: () {
              _globalKey.currentState.openDrawer();
            },
          );
  }
  Widget _appbarActions(double _width,){
    return Container(
          child: IconButton(
            iconSize: 40,
            icon: Container(
                  height: 50,
                  width: 70,
                  child: SvgPicture.asset("assets/images/02Personalizar/btn_back.svg"),
                ),
            onPressed: () => Navigator.of(context).pop(),
          ), 
        );
              
  }
  Widget _lineaJugar(double _width, int _position, String _numero, String _urlImage1, String _urlImage2, String _score1, String _score2, Function _accion ){
    return InkWell(
            onTap: _accion,
            child: Padding(
              padding: const EdgeInsets.only(left:20, right:20, ),
              child: Container(
                decoration: BoxDecoration(
                  color: !_selected[_position] ? Variables.TRANSPARENTE : Variables.AZULOSCUROTRANSPARENTE,
                  borderRadius: BorderRadius.circular(70),
                ),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: _width/7,
                      height: 90,
                      child: Center(
                        child: Text(
                          _numero,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Variables.AZULCYAN
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _width/6,
                      height: 50,
                      decoration:  BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(_urlImage1), 
                          fit: BoxFit.fitHeight
                        )
                      ),
                    ),
                    Container(
                      width: _width/4.7,
                      height: 60,
                        decoration:  BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/12Jugar/score.png"), 
                          fit: BoxFit.fitHeight
                        )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:15, right:15, bottom: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                _score1,
                                style: TextStyle(
                                  color: Variables.BLANCO,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _score2,
                                style: TextStyle(
                                  color: Variables.BLANCO,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: _width/6,
                      height: 50,
                      decoration:  BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage(_urlImage2), 
                          fit: BoxFit.fitHeight
                        )
                      ),
                    )
                  ]
                ),
              ),
            ),
          );
                      
  }
  Future<String> _asyncAnotacion(BuildContext context, double _width,) {
    String respuesta = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) { 
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color:Variables.AZULCYAN,
                width: 2
              ),
              color: Variables.AZULOSCURO,
            ),
            height: 250,
            width: _width/1.3,
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,8),
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Variables.BLANCO,
                          ),
                          height: 70.0,
                          width: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                  image: new AssetImage("assets/images/11Estadisticas/leon.png"), 
                                  fit: BoxFit.fitHeight
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        child: Text(
                          'Anotaciones',
                          style:TextStyle(
                            color: Variables.AZULCYAN,
                            fontSize: 20,
                          )
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Variables.BLANCO,
                      ),
                      width: _width/2.8,
                      child: new TextField(
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        onChanged: (value) {
                          print(respuesta);
                          respuesta = value;
                        },
                      )
                    ),
                    ],
                ), 
                Align(
                  alignment: Alignment(0, 1.25),
                  child: Container(
                    height: 50,
                    width: _width/2.5,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(respuesta);
                      },
                      color: Variables.AZULCYAN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        "Aceptar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0.9, -0.9),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Variables.GRIS,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
 }
  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Variables.GRIS,
          appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
          drawer: elDrawer(context,_globalKey, _width, _height),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Jugar',
                        style: TextStyle(
                          color: Variables.AZULOSCURO,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom:10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Variables.AZULLOGO,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: _width/1.3,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 100,
                            width: _width/3,
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Partido: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Torneo: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Fecha: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tipo: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Variables.AZULOSCURO,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Container(
                            height: 100,
                            width: _width/3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '#281 ',
                                      style: TextStyle(
                                        color: Variables.AZULCYAN,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Liga Mx ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Lunes 02 Abril 2019',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Quiniela Sencilla ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontSize: 13
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fitWidth)),
                    width: _width,
                    height: 700,
                    padding: const EdgeInsets.only(top:30,left:0, right: 0, bottom: 8),
                    child: Column(
                      children:[
                        _lineaJugar(_width,0, '1', "assets/images/11Estadisticas/leon.png", "assets/images/11Estadisticas/tigres.png", "1", "3", 
                          () async {
                            final String input = await _asyncAnotacion(context, _width);
                            print("····"+input);
                            setState()  {
                              bool actual = _selected[0];
                              _selected.replaceRange(0, 19, List.generate(20, (i) => false));
                              _selected[0] = !actual;
                              
                            } 
                          }
                        ),
                        _lineaJugar(_width,1, '2', "assets/images/11Estadisticas/monterrey.png", "assets/images/11Estadisticas/cruzazul.png", "", "", 
                          () => setState(() {
                            bool actual = _selected[1];
                            _selected.replaceRange(0, 19, List.generate(20, (i) => false));
                            _selected[1] = !actual;
                          } )
                        ),
                        _lineaJugar(_width,2, '3', "assets/images/11Estadisticas/america.png", "assets/images/11Estadisticas/necaxa.png", "", "", 
                          () => setState(() {
                            bool actual = _selected[2];
                            _selected.replaceRange(0, 19, List.generate(20, (i) => false));
                            _selected[2] = !actual;
                          } )
                        ),
                        _lineaJugar(_width,3, '4', "assets/images/11Estadisticas/tijuana.png", "assets/images/11Estadisticas/toluca.png", "", "", 
                          () => setState(() {
                            bool actual = _selected[3];
                            _selected.replaceRange(0, 19, List.generate(20, (i) => false));
                            _selected[3] = !actual;
                          } )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,30,20,0),
                          child: Container(
                            height: 50,
                            width: _width/1.3,
                            child: RaisedButton(
                              onPressed: () {
                                
                              },
                              color: Variables.AZULCYAN,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "¡Jugar Combinación!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ],
          ),
    );
  }
}