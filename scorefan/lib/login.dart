
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/home.dart';
import 'package:scorefan/signup.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    
    return   Scaffold(
      body: Center(
        child: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Variables.BLANCO,Variables.AZULOSCURO],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0,0.82],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0,-0.25),
                    radius:1.1,
                    colors: [
                       Variables.BLANCO,  
                       Variables.TRANSPARENTE,
                    ],
                     stops: [0.1,1],
                  ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: _height/2.5,
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: SvgPicture.asset("assets/sflogo/ScoreFanLogotipo.svg"),
                ),
                Container(
                  height: _height/12,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    autofocus: false,
                    decoration: new InputDecoration(
                      prefixIcon: Container(
                        height: _height/20,
                        width: _width/8,
                        // color: Colors.red,
                        child:Padding(
                          padding: const EdgeInsets.only(left:0, right: 8.0, top: 8, bottom: 8),
                          child: SvgPicture.asset("assets/images/08Login/icon_user.svg"),
                        )
                        ),
                      labelText: "Usuario",
                      labelStyle: TextStyle(
                        color:  Color(0xFF29abe2) ,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                          color: Color(0xFF142a46) ,
                          width: 2,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        
                        borderSide: new BorderSide(
                          color:Color(0xFF142a46) ,
                          width: 2,
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _height/12,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    decoration: new InputDecoration(
                      prefixIcon: Container(
                        height: _height/20,
                        width: _width/8,
                        child:Padding(
                          padding: const EdgeInsets.only(left:0, right: 8.0, top: 8, bottom: 8),
                          child: SvgPicture.asset("assets/images/08Login/icon_pass.svg"),
                        )
                        ),
                      labelText: "Contraseña",
                      labelStyle: TextStyle(
                        color:  Variables.AZULCLARO ,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                          color: Variables.AZULOSCURO ,
                          width: 2,
                        ),
                      ),
                      focusedBorder: new UnderlineInputBorder(
                        
                        borderSide: new BorderSide(
                          color: Variables.AZULOSCURO ,
                          width: 2,
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _height/18,
                  width: _width /2,
                  margin: EdgeInsets.only(top:25, bottom: 20),
                  child: RaisedButton(
                    elevation: 10,
                    color: Variables.AZULOSCURO,
                    child:Text("Login", 
                      style: TextStyle(
                        fontSize: 20,
                        color: Variables.BLANCO,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Home())),
                    ),
                ),
                Container(
                  height: _height/25,
                  width: _width /2,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: InkWell(
                      onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Signup())),
                      child:Text('Resgistrate',
                        style: TextStyle(
                          fontSize: 20,
                          color: Variables.AZULCYAN,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  height: _height/25,
                  width: _width /2,
                  child: Center(
                    child: InkWell(
                      onTap: ()=>{},
                      child:Text('Olvidé mi contraseña',
                        style: TextStyle(
                          fontSize: 20,
                          color: Variables.GRIS,
                          fontStyle: FontStyle.italic
                        ),
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}