
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/dialogs.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/signup.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{

  TextEditingController controllerEmail = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();
  TextEditingController controllerResetpass = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final focus = FocusNode(); 
  final dia = Dialogs();
  void _loguear(String email, String pass) async {
    var respuesta = await Provider.of<LoginState>(context, listen: false).login(email, pass);
    if(respuesta!='1'){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content:Text(respuesta.toString()
          ),
          backgroundColor: Variables.ROJO,
        )
      );
    }else{
      // var mymap = {"notification": {"title": "Aviso", "body": "Se ha iniciado correctamente sesión"}, "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"}};
      // PushNotificationsManager().showNotification(mymap );
    }
  }
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingresa un correo válido';
    else
      return null;
  }
  Future<String> _sendPasswordReset(String email) async { 
    String url = Variables.API_URL+'/api/password/email';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email": "'+email+'"}';
    print(json);
    await http.post(url, headers: headers, body: json);
    // Map<String, dynamic> data  = jsonDecode(response.body);
    
    return '1';
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    
    return   Scaffold(
      key: _scaffoldKey,
      body: Form(
          key: _formKey,
          child: ListView(
          children: <Widget>[ Container(
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
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      controller: controllerEmail,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      onFieldSubmitted: (v){
                        FocusScope.of(context).requestFocus(focus);
                      },
                      autofocus: false,
                      decoration: new InputDecoration(
                        prefixIcon: Container(
                          height: _height/20,
                          width: _width/8,
                          child:Padding(
                            padding: const EdgeInsets.only(left:0, right: 8.0, top: 8, bottom: 8),
                            child: SvgPicture.asset("assets/images/08Login/icon_user.svg"),
                          )
                          ),
                        labelText: "Usuario (email)",
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
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      controller: controllerPass,
                      obscureText: true,
                      focusNode: focus,
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
                      child:AutoSizeText("Login", 
                        style: TextStyle(
                          fontSize: 20,
                          color: Variables.BLANCO,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                                     _loguear(controllerEmail.text, controllerPass.text);
                        }
                      }
                        // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Home())),
                      ),
                  ),
                  Container(
                    height: _height/25,
                    width: _width /2,
                    margin: EdgeInsets.only(bottom: 15),
                    child: Center(
                      child: InkWell(
                        onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Signup())),
                        child:AutoSizeText('Resgistrate',
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
                        onTap: () async {
                          String input = await dia.asyncInput(context, _width, 'Ingresa el correo para recuperar tu contraseña');
                          await _sendPasswordReset(input);
                          FocusScope.of(context).requestFocus(new FocusNode());
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content:Text('Enviado al correo: '+input
                                ),
                                backgroundColor: Variables.ROJO,
                              )
                            );
                          
                         
                        },
                        child:AutoSizeText('Olvidé mi contraseña',
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
          ]
        ),
      )
    );
  }
}