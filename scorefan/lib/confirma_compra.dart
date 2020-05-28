import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/variables.dart';

class ConfirmaCompra extends StatefulWidget {
  @override
  _ConfirmaCompraState createState() => _ConfirmaCompraState();
}

class _ConfirmaCompraState extends State<ConfirmaCompra> {
  List formasPago = json.decode('[{"id": "1","Nombre": "Cuenta de Paypal"},{"id": "2","Nombre": "Oxxo"},{"id": "3","Nombre": "Tarjeta"}]');
  
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
  Future<String> _asyncConfirm(BuildContext context, double _width,) {
    String respuesta = '';
    return showDialog<String>(
      context: context,// dialog is dismissible with a tap on the barrier
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
            height: 200,
            width: _width/1.3,
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,30,10,20),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        child: Text(
                          'Escribir contraseña',
                          style:TextStyle(
                            color: Variables.GRIS,
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
                      width: _width/1.5,
                      child: new TextField(
                        obscureText: true,
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
              Container(
                decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
                width: _width,
                height: _height,
                child: Column(
                  children: [
                    Container(
                      height: _height/4,
                      width: _width/2,
                      child: SvgPicture.asset("assets/images/05ScorePoints/100sp.svg", fit: BoxFit.fitWidth,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Center(
                        child: Text('Confirmar Compra',
                        style: TextStyle(
                          color: Variables.BLANCO,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8),
                      child: Center(
                        child: Text('100 ScoreSaldo',
                        style: TextStyle(
                          color: Variables.AZULCYAN,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _width/1.3,
                      height: 130,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 80,
                            width: _width/1.3,
                            color: Variables.AZULOSCURO,
                            child: Text(
                              'Elige la forma de pago',
                               style: TextStyle(
                                color: Variables.BLANCO,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            color: Variables.BLANCO,
                            height: 50,
                            child: new DropdownButtonFormField(
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(left:15),
                                  labelStyle: TextStyle(
                                    color: Variables.AZULOSCURO, 
                                    fontSize: 18, fontWeight: 
                                    FontWeight.w600
                                    ),
                                ),
                              items: formasPago.map((item){
                                return new DropdownMenuItem(
                                  child: new AutoSizeText(
                                    item['Nombre'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  value: item['id'].toString(),
                                );
                              }).toList(), 
                              onChanged: (String value) {  }, 
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    Container(
                      height: _height/18,
                      width: _width /2.2,
                      margin: EdgeInsets.only(top:25, bottom: 20),
                      child: RaisedButton(
                        elevation: 5,
                        color: Variables.AZULOSCURO,
                        onPressed: () async { 
                          final String input = await _asyncConfirm(context, _width);
                          print('----------');
                          print(input);
                        },
                        child:AutoSizeText("Aceptar", 
                          style: TextStyle(
                            fontSize: 20,
                            color: Variables.BLANCO,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ]
          ),
    );
  }
}