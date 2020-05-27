import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/variables.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  
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
  Widget _estadisticasEquipo(double _width, double _height, String _urlEquipo, String _ganados, String _empatados, String _perdidos){
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Container(
        width: _width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _width/6.5,
                  width: _width/6.5,
                  decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage(_urlEquipo), fit: BoxFit.fitHeight)),

                ),
                Container(
                  alignment: Alignment.center,
                  height: _width/9,
                  width: _width/9,
                  child: AutoSizeText(
                    _ganados,
                    style: TextStyle(
                      color: Variables.BLANCO,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: _width/9,
                  width: _width/9,
                  child: AutoSizeText(
                    _empatados,
                    style: TextStyle(
                      color: Variables.BLANCO,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                  height: _width/9,
                  width: _width/9,
                  child: AutoSizeText(
                    _perdidos,
                    style: TextStyle(
                      color: Variables.BLANCO,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),
                  ),
                ),
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
    return  Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Variables.GRIS,
          appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
          drawer: elDrawer(context,_globalKey, _width, _height),
          body: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Estadísticas',
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
                decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
                width: _width,
                height: _height,
                child: Column(
                  children:[
                    Padding(
                      padding: const EdgeInsets.only(top:18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: _width/7,
                            height: _width/9,
                          ),
                          Container(
                            width: _width/9,
                            height: _width/9,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.VERDE,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'G',
                              style: TextStyle(
                                fontSize: 25,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/9,
                            height: _width/9,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.GRIS,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'E',
                              style: TextStyle(
                                fontSize: 25,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/9,
                            height: _width/9,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.ROJO,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'P',
                              style: TextStyle(
                                fontSize: 25,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        
                        Container(
                          height: _height/1.2,
                          width: _width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: _width/3.6,
                                height: _width/9,
                              ),
                              Container(
                                width:_width - _width/3.6,
                                child: Row(
                                  children: [
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/5.7,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/5.7,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/pachuca.png", "3", "2", "4"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/leon.png", "4", "0", "7"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/tigres.png", "6", "0", "1"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/monterrey.png", "5", "3", "2"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/cruzazul.png", "3", "4", "1"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/america.png", "6", "0", "1"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/necaxa.png", "3", "4", "1"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/tijuana.png", "5", "3", "2"),
                            _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/toluca.png", "6", "0", "1"),
                          ],
                        ),
                        ],
                    )
                  ]
                ),
              )
            ],
          ),
    );
  }
}