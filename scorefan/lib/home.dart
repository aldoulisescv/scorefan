
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/classes/variables.dart';

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
              child: Text(
                _position,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _color
                  ),
              ),
            ),
          ),
          Container(
            width: _width/2.1,
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
                  child: Text(
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
            width: _width/5,
            child: Center(
              child: Text(
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
            child:Text(_nombre,
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
  RichText _noticiaTextoCompleto(){
    return RichText(text: TextSpan(children:[
      _noticiaNormal("Dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor "),
      _noticiaAzul('#incididunt '),
      _noticiaNormal('ut labore et '),
      _noticiaAzul('@dolore '),
      _noticiaNormal('magna aliqua.😀😀😀'),
      
    ] ),);
  }
  Widget _noticia(double _width, String _urlImage,String _nombre, RichText _texto ){
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
              padding: const EdgeInsets.only( right: 20),
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
                  child: RichText(
                    text:_noticiaNombre(_nombre)
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
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/07News/background.jpg"), fit: BoxFit.fill)),
        child: Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              title: new Text(''),
              backgroundColor:Variables.TRANSPARENTE,
              leading:IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40,
                onPressed: () {
                  _globalKey.currentState.openDrawer();
                },
              ),
              elevation: 0,
              actions: <Widget>[
                  Container(
                    width: _width/1.82,
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: _width/2.5,
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
                                      Text('Saldo:', 
                                        style: TextStyle(
                                          color: Variables.AZULOSCURO,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text('2,300 SP', 
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
                                      Text('Ranking:', 
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Variables.AZULOSCURO
                                        ),
                                      ),
                                      Text('15', 
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
                          transform: Matrix4.translationValues(-12, 0, 0),
                          child: SvgPicture.asset("assets/images/10home/icon_notif.svg",),
                        ),
                       Container(
                          // width: _width/8,
                          transform: Matrix4.translationValues(-42, 0, 0),
                          child: Text('2',style: TextStyle(
                                          color: Variables.ROJO,
                                          fontWeight: FontWeight.bold,
                                        ), ),
                        ),
                      ],
                    ),
                  )
              ]
          ),
          drawer:Container(
            width: _width,
            height: _height,
            color: Color(0xFF314c63),
            child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Container(
                  height: _height/10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    color: Variables.BLANCO,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              ListTile(
                title: Center(
                  child: Text("Mi cuenta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                onTap: () {
                  print('Mi cuenta');
                },
              ),
              ListTile(
                title: Center(
                  child: Text("Mis compras",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                onTap: () {
                  print('Mis compras');
                },
              ),
              ListTile(
                title: Center(
                  child: Text("Opcione de pago",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                onTap: () {
                  print('Opcione de pago');
                },
              ),
              ListTile(
                title: Center(
                  child: Text("Notificaciones",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                onTap: () {
                  print('Notificaciones');
                },
              ),
              SizedBox(
                      height: 50.0,
                    ),
              ListTile(
                title: Center(
                  child: Text("Salir",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                    ),
                  ),
                ),
                onTap: () {
                  print('Salir');
                },
              )
          ],
        ),
  ),
          body: ListView(
            children:[ 
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  decoration:BoxDecoration(
                    image:DecorationImage(
                      image: AssetImage("assets/images/10home/top board.png"),
                    ),
                  ),
                  height: 172,
                  child: Column(
                    children: [
                      Container(
                        height: 42,
                        child: Center(
                          child: Text(
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
                                child: Text(
                                  'Posición',
                                  style: TextStyle(
                                    fontSize: 13
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              width: _width/2.1,
                              child: Center(
                                child: Text(
                                  'Jugador',
                                  style: TextStyle(
                                    fontSize: 13
                                    ),
                                ),
                              ),
                            ),
                            Container(
                              width: _width/5,
                              child: Center(
                                child: Text(
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
                padding: const EdgeInsets.only(left:25.0, right: 25, bottom: 15),
                child: Container(
                  height: 160,
                  child: _botonHome('Jugar', 'assets/images/10home/icon_jugar.svg', () {
                          print('Jugar');
                        })
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0, right: 25, bottom: 15),
                child: Container(
                  height: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Container(
                        height: 160,
                        width: _width/2.38,
                        child: _botonHome('Mi perfil', 'assets/images/10home/icon_perfil.svg',() {
                                  print('Mi perfil');
                                })
                      ),
                      Container(
                        height: 160,
                        width: _width/2.38,
                        child: _botonHome('Tienda', 'assets/images/10home/icon_tienda.svg', () {
                                  print('Tienda');
                                })
                      ),
                    ]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:25.0, right: 25, bottom: 15),
                child: Container(
                  height: 160,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Container(
                        height: 160,
                        width: _width/2.38,
                        child: _botonHome('Ranking', 'assets/images/10home/icon_ranking.svg',() {
                                  print('Ranking');
                                })
                      ),
                      Container(
                        height: 160,
                        width: _width/2.38,
                        child: _botonHome('Equipos', 'assets/images/10home/icon_equipos.svg', () {
                                  print('Equipos');
                                })
                      ),
                    ]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:25, bottom: 100, left: 25, right: 25),
                child: Container(
                  height: 350,
                  // color: Variables.AZULLOGO,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: Center(
                          child: Text('Noticias',
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
            ],
          ),
        ),
      ),
    );
  }
}