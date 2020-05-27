import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/jugar.dart';
import 'package:scorefan/perfil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  
  Widget _topPosition(String _position, String _urlImage, String _nombre, String _score, Color _color, double _width, double _height){
    return Container(
      height: 30,
      child: Row(
        children: [
          Container(
            width: _width/5,
            child: Center(
              child: AutoSizeText(
                _position,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _color
                  ),
              ),
            ),
          ),
          Container(
            width: _width/2.05,
            child: Row(
              children: [
                Container(
                  width: _width/7,
                  height: _height/28,
                  decoration:BoxDecoration(
                    image:DecorationImage(
                      image: AssetImage(_urlImage),
                    ),
                  ),
                ),
                Center(
                  child: AutoSizeText(
                    _nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Variables.AZULOSCURO
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: _width/5.2,
            child: Center(
              child: AutoSizeText(
                _score,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _color
                  ),
              ),
            ),
          ),
        ],
      ),
    );
                      
  }
  Widget _botonHome(String _nombre, String _urlImage, Function _accion){
    return RaisedButton(
      color: Variables.GRIS,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Variables.GRIS)
      ),
      onPressed: _accion,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 80,
            child: SvgPicture.asset(_urlImage),
          ),
          Container(
            child:AutoSizeText(_nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Variables.AZULOSCURO
              ),
            )
          )
        ], 
      ),
    );
  }
  TextSpan _noticiaNombre(String _texto){
    return TextSpan(
      text: _texto,
      style: TextStyle(
          color: Variables.AZULCYAN,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    );
  }
  TextSpan _noticiaNormal(String _texto){
    return TextSpan(
      text: _texto,
      style: TextStyle(
          color: Variables.GRIS,
          fontSize: 13
      ),
    );
  }
  TextSpan _noticiaAzul(String _texto){
    return TextSpan(
      text: _texto,
      style: TextStyle(
          color: Variables.AZULCYAN,
          fontSize: 12
      ),
    );
  }
  AutoSizeText _noticiaTextoCompleto(){
    return AutoSizeText.rich(
      TextSpan(children:[
      _noticiaNormal("Dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor "),
      _noticiaAzul('#incididunt '),
      _noticiaNormal('ut labore et '),
      _noticiaAzul('@dolore '),
      _noticiaNormal('magna aliqua.😀😀😀'),
      
    ] ),);
  }
  Widget _noticia(double _width, String _urlImage,String _nombre, AutoSizeText _texto ){
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Variables.AZULOSCURO),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding:  EdgeInsets.only( right: _width/25),
              child:  Column(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Variables.TRANSPARENTE,
                    child:Container(
                      width: _width/6.9,
                      height: 70,
                      decoration:BoxDecoration(
                        image:DecorationImage(
                          image: AssetImage(_urlImage),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: _width/1.47,
                  child: AutoSizeText.rich(
                    _noticiaNombre(_nombre)
                  )
                ),
                Container(
                  width: _width/1.47,
                  height: 49,
                  child: _texto,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget _leadingIcon(){
    return IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40,
                onPressed: () {
                  _globalKey.currentState.openDrawer();
                },
              );
  }
  Widget _appbarActions(double _width,){
    return Container(
          width: _width/1.8,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(

                transform: Matrix4.translationValues(12, 0, 0),
                width: _width/2.4,
                decoration:BoxDecoration(
                  image:DecorationImage(
                    image: AssetImage("assets/images/10home/notif_back.png"),
                  ),
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:8, top:8.0, bottom: 8.0),
                      child: Container(
                        width: _width/6.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AutoSizeText('Saldo:', 
                              style: TextStyle(
                                color: Variables.AZULOSCURO,
                                fontSize: 13,
                              ),
                            ),
                            AutoSizeText('2,300 SP', 
                              style: TextStyle(
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                          ),
                        ),
                    ),
                    VerticalDivider(
                      color: Variables.AZULCLARO,
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                      child: Container(
                        width: _width/6.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AutoSizeText('Ranking:', 
                              style: TextStyle(
                                fontSize: 13,
                                color: Variables.AZULOSCURO
                              ),
                            ),
                            AutoSizeText('15', 
                              style: TextStyle(
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                          ),
                        ),
                    ),
                  ]
                ),
              ),
                
              Container(
                width: _width/8,
                height: 52,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/10home/icon_notif.png"), 
                    fit: BoxFit.fill,
                  )
                ),
                child: Center(
                  child: AutoSizeText('2',
                    style: TextStyle(
                      color: Variables.ROJO,
                      fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
              ),
              
            ],
          ),
        );
              
  }
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Container(
        color: Variables.AZULLOGO,
        child: Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Colors.transparent,
          appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
          drawer:elDrawer(context,_globalKey, _width, _height),
          body: SingleChildScrollView(
                child: new Container(
                  decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/07News/background.jpg"), fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Variables.TRANSPARENTE,Variables.AZULLOGO],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0,0.82],
                      ),
                    ),
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration:BoxDecoration(
                              image:DecorationImage(
                                image: AssetImage("assets/images/10home/top board.png"),
                              ),
                            ),
                            height: 170,
                            child: Column(
                              children: [
                                Container(
                                  height: 42,
                                  child: Center(
                                    child: AutoSizeText(
                                      'TOP 3',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Variables.AZULOSCURO
                                        ),
                                      )
                                    ),
                                ),
                                Container(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: _width/5,
                                        child: Center(
                                          child: AutoSizeText(
                                            'Posición',
                                            style: TextStyle(
                                              fontSize: 13
                                              ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width/2.05,
                                        child: Center(
                                          child: AutoSizeText(
                                            'Jugador',
                                            style: TextStyle(
                                              fontSize: 13
                                              ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: _width/5.2,
                                        child: Center(
                                          child: AutoSizeText(
                                            'Puntos',
                                            style: TextStyle(
                                              fontSize: 13
                                              ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _topPosition("1", "assets/images/07News/avatar03.png", "Jorge Hernádez", "1,739", Variables.AZULOSCURO, _width, _height),
                                _topPosition("2", "assets/images/07News/avatar01.png", "Ana Vázquez", "1,639", Variables.BLANCO, _width, _height),
                                _topPosition("3", "assets/images/07News/avatar02.png", "Raul Pérez", "1,274", Variables.AZULOSCURO, _width, _height),

                              
                              ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0, right: 20, bottom: 15),
                          child: Container(
                            height: 160,
                            child: _botonHome('Jugar', 'assets/images/10home/icon_jugar.svg', () {
                                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Jugar()));
                                  })
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0, right: 20, bottom: 15),
                          child: Container(
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Container(
                                  height: 160,
                                  width: _width/2.3,
                                  child: _botonHome('Mi perfil', 'assets/images/10home/icon_perfil.svg',() {
                                             Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Perfil()));
                                          })
                                ),
                                Container(
                                  height: 160,
                                  width: _width/2.3,
                                  child: _botonHome('Tienda', 'assets/images/10home/icon_tienda.svg',
                                  null
                                      //  () {
                                      //       print('Tienda');
                                      //     }
                                          )
                                ),
                              ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0, right: 20, bottom: 15),
                          child: Container(
                            height: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                Container(
                                  height: 160,
                                  width: _width/2.3,
                                  child: _botonHome('Ranking', 'assets/images/10home/icon_ranking.svg',
                                  null
                                  // () {
                                  //           print('Ranking');
                                  //         }
                                  )
                                ),
                                Container(
                                  height: 160,
                                  width: _width/2.3,
                                  child: _botonHome('Equipos', 'assets/images/10home/icon_equipos.svg',
                                  null
                                        //  () {
                                        //     print('Equipos');
                                        //   }
                                          )
                                ),
                              ]
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20, bottom: 100, left: 20, right: 25),
                          child: Container(
                            height: 350,
                            // color: Variables.AZULLOGO,
                            child: Column(
                              children: [
                                Container(
                                  height: 60,
                                  child: Center(
                                    child: AutoSizeText('Noticias',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Variables.BLANCO
                                      ),
                                    ),
                                  ),
                                ),
                                _noticia(_width, "assets/images/07News/avatar03.png", 'Alejandro Caballero', _noticiaTextoCompleto()),
                                _noticia(_width, "assets/images/07News/avatar02.png", 'Tomás Acosta', _noticiaTextoCompleto()),
                                _noticia(_width, "assets/images/07News/avatar01.png", 'Marcela Aguilar', _noticiaTextoCompleto()),
                              ],
                            ),
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            
        ),
      ),
    );
  }
}