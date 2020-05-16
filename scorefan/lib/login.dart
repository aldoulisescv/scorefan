
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFFFFF),Color(0xFF142a46)],
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
                      const Color(0xFFFFFFFF),  
                      const Color(0X00FFFFFF),
                    ],
                     stops: [0.1,1],
                  ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/2.5,
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: SvgPicture.asset("assets/sflogo/ScoreFanLogotipo.svg"),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/12,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    autofocus: false,
                    decoration: new InputDecoration(
                      prefixIcon: Container(
                        height: MediaQuery.of(context).size.height/20,
                        width: MediaQuery.of(context).size.width/8,
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
                  height: MediaQuery.of(context).size.height/12,
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: TextField(
                    decoration: new InputDecoration(
                      prefixIcon: Container(
                        height: MediaQuery.of(context).size.height/20,
                        width: MediaQuery.of(context).size.width/8,
                        // color: Colors.red,
                        child:Padding(
                          padding: const EdgeInsets.only(left:0, right: 8.0, top: 8, bottom: 8),
                          child: SvgPicture.asset("assets/images/08Login/icon_pass.svg"),
                        )
                        ),
                      labelText: "Contraseña",
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
                          color: Color(0xFF142a46) ,
                          width: 2,
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/18,
                  width: MediaQuery.of(context).size.width /2,
                  margin: EdgeInsets.only(top:25, bottom: 20),
                  child: RaisedButton(
                    elevation: 10,
                    color: Color(0xFF142a46),
                    child:Text("Login", 
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
                  height: MediaQuery.of(context).size.height/25,
                  width: MediaQuery.of(context).size.width /2,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Center(
                    child: InkWell(
                      onTap: ()=>{},
                      child:Text('Resgistrate',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF00ffff),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/25,
                  width: MediaQuery.of(context).size.width /2,
                  child: Center(
                    child: InkWell(
                      onTap: ()=>{},
                      child:Text('Olvidé mi contraseña',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[300],
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