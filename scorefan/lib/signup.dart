import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/home.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List equipos = json.decode('[{"id": "1","Nombre": "America"},{"id": "3","Nombre": "Pumas"},{"id": "24","Nombre": "Guadalajara"},{"id": "26","Nombre": "Cruz Azul"}]');
  bool _valueCheck = false;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          iconSize: 40,
          icon: Container(
                height: 50,
                width: 50,
                child: SvgPicture.asset("assets/images/02Personalizar/btn_back.svg"),
              ),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView(
        children:[ 
          Container(
            width: _width,
            child: Column(
              children: <Widget>[
                Container(
                  height: _height/18,
                  child: Center(
                    child: AutoSizeText('Registro',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ),
                ),
                Container(
                  margin: EdgeInsets.only( left:_width/10, right: _width/10,),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new DropdownButtonFormField(
                        decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Equipo Favorito',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        items: equipos.map((item){
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
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Ciudad',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Fecha de nacimiento',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Correo Electrónico',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        child: new TextFormField(
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left:15),
                            labelText: 'Confirmar contraseña',
                            labelStyle: TextStyle(
                              color: Variables.AZULCLARO, 
                              fontSize: 18, fontWeight: 
                              FontWeight.w600
                              ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top:5),
                        width: _width,
                        child: Row(
                          children:<Widget>[
                            Container(
                              child: Checkbox(
                                activeColor: Variables.AZULOSCURO,
                                value: _valueCheck,
                                onChanged: (bool value) { 
                                  setState(() {
                                    _valueCheck = value;
                                  });  },),
                            ),
                            Container(
                              child:AutoSizeText(
                                'Acepto los términos y condiciones', 
                                style: TextStyle(
                                fontWeight:FontWeight.bold,
                                color: Variables.AZULOSCURO
                                ),
                              )
                            )
                          ]
                        ),
                      ),
                      Container(
                        height: _height/18,
                        width: _width /2.2,
                        margin: EdgeInsets.only(top:25, bottom: 20),
                        child: RaisedButton(
                          elevation: 10,
                          color: Color(0xFF142a46),
                          child:AutoSizeText("Registrar", 
                            style: TextStyle(
                              fontSize: 20,
                              color: Variables.BLANCO,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Home())),
                    
                          ),
                      ),
                      Container(
                        height: _height/18,
                        width: _width /1.7,
                        margin: EdgeInsets.only(top:25, bottom: 20),
                        child: RaisedButton(
                          elevation: 10,
                          color: Variables.AZULFACEBOOK,
                          child:AutoSizeText("Registrar con Facebook", 
                            style: TextStyle(
                              fontSize: 17,
                              color: Variables.BLANCO,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          onPressed: ()=>{},
                          ),
                      ),
                    ]
                  ),
                ),
              ],
            )
          ),
        ]
      ),
    );
  }
}