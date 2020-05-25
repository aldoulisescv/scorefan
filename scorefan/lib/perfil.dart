import 'package:flutter/material.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/edit_perfil.dart';
class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
              child: SvgPicture.asset("assets/images/01Home/btn_home.svg"),
            ),
        onPressed: () => Navigator.of(context).pop(),
      ), 
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      backgroundColor: Variables.GRIS,
      key: _globalKey,
      appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
      drawer: elDrawer(context,_globalKey, _width, _height),
      body: ListView(
        children:[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Jaime',
                style: TextStyle(
                  color: Variables.AZULOSCURO,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 250,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0.6, -1),
                    child: IconButton(
                      iconSize: 35,
                        icon: Container(
                        child: SvgPicture.asset("assets/images/01Home/btn_edit.svg"),
                      ), 
                      onPressed: () { 
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new EditPerfil()));
                       },
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 250,
                      width: _width,
                      child: SvgPicture.asset("assets/images/01Home/avatar.svg"), 
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
            width: _width,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Resumen',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Variables.AZULCYAN
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Container(
                      width: _width,
                      child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width/3,
                                child: Text('Puntuacion',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width/3,
                                child: Text('167 pts',
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width/3,
                                child: Text('Mi equipo',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width/3,
                                child: Text('Chivas',
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width/3,
                                child: Text('ScorePoints',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width/3,
                                child: Text('1,568 SP',
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Historial',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Variables.AZULCYAN
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          '26/07/2019',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Variables.GRISOSCURO
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        indent: 40,
                        endIndent: 40,
                      ),
                      Container(
                        width: _width/1.5,
                        child: Text(
                          '■ Actualización de perfil',
                          style: TextStyle(
                            fontSize: 18,
                            color: Variables.GRISMEDIO
                          ),
                        ),
                      ),
                      Container(
                        width: _width/1.5,
                        child: Text(
                          '■ Compra de catálogo',
                          style: TextStyle(
                            fontSize: 18,
                            color: Variables.GRISMEDIO
                          ),
                        ),
                      ),
                      Container(
                        width: _width/1.5,
                        child: Text(
                          '■ Cargo a tarjeta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Variables.GRISMEDIO
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          )
        ] 
      ),
    );
  }
}