import 'package:flutter/material.dart';
import 'package:scorefan/classes/variables.dart';

Widget elAppbar(GlobalKey<ScaffoldState> _globalKey, double _width, Widget _leadingIcon, Widget _actions ){
  return AppBar(
              backgroundColor:Variables.TRANSPARENTE,
              leading: _leadingIcon,
              elevation: 0,
              actions: <Widget>[
                _actions,
                  ]
          );
}