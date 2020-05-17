import 'dart:convert';

import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List equipos = json.decode('[{"id": "1","Nombre": "America"},{"id": "3","Nombre": "Pumas"},{"id": "24","Nombre": "Guadalajara"},{"id": "26","Nombre": "Cruz Azul"}]');
  bool _valueCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: IconButton(
          icon: Container(
            decoration: new BoxDecoration(
              color: Color(0xFF00dadf),
              shape: BoxShape.circle,
            ),
            height: 50,
            width: 50,
            child: Icon(Icons.keyboard_backspace, color: Colors.white, size: 30,)),
            onPressed: () => Navigator.of(context).pop(),
        ), 
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/25,
              child: Center(
                child: Text('Registro',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ),
            ),
            Container(
              margin: EdgeInsets.only( left:60, right: 60),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:5),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(left:15),
                        labelText: 'Nombre',
                        labelStyle: TextStyle(
                          color: Color(0xFF6dccef), 
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
                          color: Color(0xFF6dccef), 
                          fontSize: 18, fontWeight: 
                          FontWeight.w600
                          ),
                      ),
                    items: equipos.map((item){
                      return new DropdownMenuItem(
                        child: new Text(
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
                          color: Color(0xFF6dccef), 
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
                          color: Color(0xFF6dccef), 
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
                          color: Color(0xFF6dccef), 
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
                          color: Color(0xFF6dccef), 
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
                          color: Color(0xFF6dccef), 
                          fontSize: 18, fontWeight: 
                          FontWeight.w600
                          ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:5),
                    child: Row(
                      children:<Widget>[
                        Container(
                          child: Checkbox(
                            activeColor: Color(0xFF0e2a48),
                            value: _valueCheck,
                            onChanged: (bool value) { 
                              setState(() {
                                _valueCheck = value;
                              });  },),
                        ),
                        Container(
                          child :Text('Acepto los términos y condiciones', 
                                  style: TextStyle(
                                  fontWeight:FontWeight.bold,
                                  color: Color(0xFF0e2a48)
                                  ),
                             )
                        )
                      ]
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/18,
                    width: MediaQuery.of(context).size.width /2.2,
                    margin: EdgeInsets.only(top:25, bottom: 20),
                    child: RaisedButton(
                      elevation: 10,
                      color: Color(0xFF142a46),
                      child:Text("Registrar", 
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: ()=>{},
                      ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/18,
                    width: MediaQuery.of(context).size.width /1.7,
                    margin: EdgeInsets.only(top:25, bottom: 20),
                    child: RaisedButton(
                      elevation: 10,
                      color: Color(0xFF365aa0),
                      child:Text("Registrar con Facebook", 
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
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
    );
  }
}