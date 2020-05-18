import 'package:flutter/material.dart';
import 'package:scorefan/login.dart';

void main() => runApp(Scorefan());


class Scorefan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'ScoreFan',
      home: Login(),
    );
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.red
    // ));
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]) ;
    // return Login();
    // return ChangeNotifierProvider<LoginState>(
    //   create: (BuildContext context) => LoginState(),
    //   child :MaterialApp(
    //      localizationsDelegates: [
    //         // ... app-specific localization delegate[s] here
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //       ],
    //        supportedLocales: [
    //         const Locale('en'), // English
    //         const Locale('es'), // Español
    //       ],
    //       debugShowCheckedModeBanner: false,
    //       title: 'Garde',
    //       theme: new ThemeData(
    //         primaryColor: Colors.red,
    //         accentColor: Colors.yellow,
    //         splashColor: Colors.pink,
    //       ),
    //       routes: {
    //         '/': (BuildContext context){
    //           var state = Provider.of<LoginState>(context, listen: true).isLoggedIn();
              
    //           if(state){
    //             return HomePage();
    //           }else{
    //             return LoginPage();
    //             // /return NetworkSensitive();
    //           }
    //         },
    //       },
    //     ),
    // );
  }
}