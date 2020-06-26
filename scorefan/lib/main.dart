import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scorefan/home.dart';
import 'package:scorefan/login.dart';
import 'package:provider/provider.dart';

import 'classes/login_state.dart';

void main() => runApp(Scorefan());


class Scorefan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    ));
    return ChangeNotifierProvider<LoginState>(
      create: (BuildContext context) => LoginState(),
      child :MaterialApp(
        title: 'Scorefan',
      
        routes: {
          '/': (BuildContext context){
            var state = Provider.of<LoginState>(context, listen: true).isLoggedIn();
            
            if(state){
              return Home();
            }else{
              return Login();
              // /return NetworkSensitive();
            }
          },
        },
      ),
    );
    // return MaterialApp(
    //   title: 'ScoreFan',
    //   home: Login(),
    // );
  }
}