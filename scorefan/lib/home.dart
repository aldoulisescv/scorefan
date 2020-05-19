
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/classes/variables.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/07News/background.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
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
                          child: SvgPicture.asset("assets/images/10home/icon_notif.svg"),
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
            children:[ Container(
              height: _height,

              //color: Variables.AZULCLARO,
              ),
            ],
          ),
        ),
      ),
    );
  }
}