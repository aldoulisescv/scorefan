import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';

Widget elDrawer(BuildContext context, GlobalKey<ScaffoldState> _globalKey,double _width, double _height,){
  return Container(
            width: _width,
            height: _height,
            color: Variables.AZULLOGO,
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
                       _globalKey.currentState.openEndDrawer();
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
                  Provider.of<LoginState>(context, listen: false).logout();
                },
              )
          ],
        ),
  );
}