// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/confirma_compra.dart';

class Productos extends StatefulWidget {
  @override
  _ProductosState createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('ScoreSaldo',
                  style: TextStyle(
                    color: Variables.AZULOSCURO,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                   Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new ConfirmaCompra()));
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: _height/4,
                        width: _width/2,
                        child: SvgPicture.asset("assets/images/05ScorePoints/100sp.svg", fit: BoxFit.fitWidth,),
                      ),
                       Center(
                        child: Text('100ss',
                          style: TextStyle(
                            color: Variables.AZULOSCURO,
                            fontSize: 35,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Center(
                        child: Text("\$ 150.00",
                          style: TextStyle(
                            color: Variables.VERDE,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: _height/4,
                      width: _width/2,
                      child: SvgPicture.asset("assets/images/05ScorePoints/200sp.svg", fit: BoxFit.fitWidth,),
                    ),
                      Center(
                      child: Text('200ss',
                        style: TextStyle(
                          color: Variables.AZULOSCURO,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Center(
                      child: Text("\$ 200.00",
                        style: TextStyle(
                          color: Variables.VERDE,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: _height/4,
                      width: _width/2,
                      child: SvgPicture.asset("assets/images/05ScorePoints/300sp.svg", fit: BoxFit.fitWidth,),
                    ),
                      Center(
                      child: Text('100ss',
                        style: TextStyle(
                          color: Variables.AZULOSCURO,
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Center(
                      child: Text("\$ 250.00",
                        style: TextStyle(
                          color: Variables.VERDE,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    
    );
  }
}