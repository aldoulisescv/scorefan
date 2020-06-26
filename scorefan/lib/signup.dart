import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scorefan/aviso_privacidad.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:transparent_image/transparent_image.dart';
import 'classes/http_service.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  List equipos =List();
  bool _valueCheck = false;
  String equipoId;
  TextEditingController cntrlNombre = new TextEditingController();
  TextEditingController cntrlEmail= new TextEditingController();
  TextEditingController cntrlConfirmPass= new TextEditingController();
  TextEditingController cntrlPass= new TextEditingController();
  final focusEmail = FocusNode();
  final focusConfirmPass = FocusNode();
  final focusPass = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  HttpService http = new HttpService();
  void getEquipos() async {
    String url =  Variables.API_URL+'/api/teams';
    Map<String, dynamic> data = await http.get(url);
    if(data['ex']!=null){
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(data['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      setState( () {
        equipos = data['data'];
      });
    }
    
  }
  void _signUp(String name, String email, String _pass, String _confirmPass, String _teamId) async {
    // set up POST request arguments
    if (_teamId==null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Selecciona un equipo'),
          backgroundColor: Colors.red,
        )
      );
    } else {
      String url = Variables.API_URL+'/api/register';
      String json = '{"name": "'+name+'", "email": "'+email+'", "team_id": "'+_teamId+'", "password": "'+_pass.toString()+'", "password_confirmation": "'+_confirmPass.toString()+'", "user_type": "user", "enabled": "1","terms": "1","privacy_notice": "1", "balance": "0"  }';
      // http.Response response = await http.post(url, headers: headers, body: json);
      Map<String, dynamic> data  = await http.post(url, json);
       if(data['ex']!=null){
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(data['ex']),
            backgroundColor: Colors.red,
          )
        );
      }else{
        if (data['error']=='1') {
          String message = data['message'];
          int cuantos = data['cuenta'];
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content:Container(
                alignment: Alignment.centerLeft,
                height: (MediaQuery.of(context).size.height/20)*cuantos,
                child: ListView(
                  children: message
                      .split(',')                       // split the text into an array
                      .map((String text) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text),
                      )) // put the text inside a widget
                      .toList(),                        // convert the iterable to a list
                ),
              ),
              backgroundColor: Variables.ROJO,
            ),
          );
        } else {
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Cuenta Registrada! Verifica tu correo e incia sesión'),
              backgroundColor: Variables.VERDE,
            ),
          ).closed.then((SnackBarClosedReason reason) {
              Navigator.pop(context);
          });
        }
      }
    }
  }
  void initState() {
    super.initState();
    this.getEquipos();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Ingresa un correo valido';
    else
      return null;
  }
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
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
      body: Form(
          key: _formKey,
          child: ListView(
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
                    height: _height/1.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                              child: Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: Variables.API_URL+'/storage/'+item['logo_url'],
                                      ),
                                  ),
                                  SizedBox(width: 10,),
                                  new AutoSizeText(
                                    item['name'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              value: item['id'].toString(),
                            );
                          }).toList(), 
                            onChanged: (String value) {  
                              setState(() {
                                equipoId = value;
                              });
                            }, 
                          ),
                        ),
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
                            controller: cntrlNombre,
                            validator: (value) {
                              String text;
                              if(value.length < 5){
                                text = 'El nombre es muy corto';
                              }
                              return text;
                            },
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focusEmail);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:5),
                          child: new TextFormField(
                            controller:cntrlEmail,
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail,
                            textInputAction: TextInputAction.next,
                            focusNode: focusEmail,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focusPass);
                            },
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
                            controller:cntrlPass,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              String text;
                              if(value.length < 5){
                                text = 'La contraseña debe ser mayor a 5 carácteres';
                              }
                              return text;
                            },
                            focusNode: focusPass,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(focusConfirmPass);
                            },
                            obscureText: true,
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
                            controller:cntrlConfirmPass,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              String text;
                              if(value.length < 5){
                                text = 'La contraseña debe ser mayor a 5 carácteres';
                              }
                              return text;
                            },
                            focusNode: focusConfirmPass,
                            obscureText: true,
                            onFieldSubmitted: (v){
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
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
                                child:Row(
                                  children:[
                                    AutoSizeText(
                                      'Acepto los ',
                                      style: TextStyle(
                                        fontWeight:FontWeight.bold,
                                        color: Variables.GRISOSCURO
                                      ),
                                    ),
                                    InkWell(
                                      child: AutoSizeText(
                                        'términos y condiciones',
                                        style: TextStyle(
                                          fontWeight:FontWeight.bold,
                                          color: Variables.AZULCLARO,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      onTap: () {
                                        print('va a terminos y condiciones');
                                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new AvisoPrivacidad()));
                                      },
                                    ),
                                  ],
                                 
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
                            elevation: (_valueCheck)?10:2,
                            color: (_valueCheck)?Variables.AZULOSCURO:Variables.GRISMEDIO,
                            child:AutoSizeText("Registrar", 
                              style: TextStyle(
                                fontSize: 20,
                                color: Variables.BLANCO,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: (){
                              if (_valueCheck) {
                                if (_formKey.currentState.validate()) {
                                  _signUp(cntrlNombre.text , cntrlEmail.text, cntrlPass.text, cntrlConfirmPass.text, equipoId);
                                }
                              } else {
                                null;
                              }
                            }
                             
                            ),
                        ),
                        // Container(
                        //   height: _height/18,
                        //   width: _width /1.7,
                        //   margin: EdgeInsets.only(top:25, bottom: 20),
                        //   child: RaisedButton(
                        //     elevation: 10,
                        //     color: Variables.AZULFACEBOOK,
                        //     child:AutoSizeText("Registrar con Facebook", 
                        //       style: TextStyle(
                        //         fontSize: 17,
                        //         color: Variables.BLANCO,
                        //         fontWeight: FontWeight.bold
                        //       ),
                        //     ),
                        //     onPressed: ()=>{},
                        //     ),
                        // ),
                      ]
                    ),
                  ),
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
}