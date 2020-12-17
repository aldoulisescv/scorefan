import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/edit_perfil.dart';
import 'package:http/http.dart' as htt;
class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String _nombre='';
  String _userId='';
  String _authtoken='';
  String _miEquipo='';
  String _scorePoints='';
  String _puntos='0 pts';
  HttpService http = new HttpService();
  List<dynamic> _categorias = List<dynamic>();
  Map<dynamic,dynamic>_seleccionados = Map<dynamic,dynamic>();
  bool _existeAvatar = false;
  Widget _leadingIcon(){
    return IconButton(
            icon: const Icon(Icons.menu),
            color: Variables.AZULOSCURO,
            iconSize: 40,
            onPressed: () {
              _globalKey.currentState.openDrawer();
            },
          );
  }
  
  Widget _appbarActions(double _width,){
    return Container(
      child: IconButton(
        iconSize: 40,
        icon: Container(
              child: SvgPicture.asset("assets/images/01Home/btn_home.svg"),
            ),
        onPressed: () => Navigator.of(context).pop(),
      ), 
    );
  }
  Future<void> getResumen() async {
    String url =  Variables.API_URL+'/api/resumen/'+_userId;
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      setState(() {
        _miEquipo = response['data']['team'].toString();
        _scorePoints = response['data']['balance'].toString()+' SP';
      });
    }
  }
  Future<void> getCategories() async {
    String url =  Variables.API_URL+'/api/categories?enabled=1&affect_balance=false';
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      // await new Future.delayed(const Duration(seconds : 3));
      print(response['data']);
      for (var item in response['data']) {
        await cargaSeleccionados(item['id']);
      }
      setState(() {
        _categorias=response['data'];
        print('_categorias');
        print(_categorias);
      });
    }
  }
  Future<void> getRank() async {
    String url =  Variables.API_URL+'/api/myRank/'+_userId;
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      setState(() {
        _puntos = response['data']['points'].toString()+' pts';
      });
    }
  }
  Future<void> checkAvatar() async {
    final response =await htt.head(Variables.API_URL + "/storage/avatars/avatar_"+_userId+".png");

  if (response.statusCode == 200) {
      setState(() {
        _existeAvatar = true;
      });
    }
  }
  Future<void> cargaSeleccionados(int cat) async {
    Map<dynamic,dynamic>_seleccionadosTemp = Map<dynamic,dynamic>();

    String url =  Variables.API_URL+'/api/accessories?enabled=1&selected=1&user_id='+_userId;
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      for (var item in response['data']) {
        String url =  Variables.API_URL+'/api/products/'+item['product_id'].toString();
        print(url);
        Map<String, dynamic> resp = await http.get(url, _authtoken);  
        if(resp['ex']!=null){
          _globalKey.currentState.showSnackBar(
            SnackBar(
              content: Text(resp['ex']),
              backgroundColor: Colors.red,
            )
          );
        }else{
          print(resp);
          _seleccionadosTemp[resp['data']['category_id'].toString()]=item['product_id'];
        }
      }
      setState(() {
        _seleccionados=_seleccionadosTemp;
        print(_seleccionados);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    setState(()  {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      _userId = Provider.of<LoginState>(context, listen: false).getUserId();
      _nombre = Provider.of<LoginState>(context, listen: false).getNombre();
      this.getResumen();
      this.getCategories();
      this.getRank();
      this.checkAvatar();
    });
  }
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      backgroundColor: Variables.GRIS,
      key: _globalKey,
      appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
      drawer: elDrawer(context,_globalKey, _width, _height),
      body: ListView(
        children:[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(_nombre,
                style: TextStyle(
                  color: Variables.AZULOSCURO,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 250,
              child: Stack(
                children: [
                   Center(
                    child: Container(
                      height: 250,
                      width: _width,
                      child:(_existeAvatar)?Image.network(Variables.API_URL + "/storage/avatars/avatar_"+_userId+".png",
                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                            return Text(exception.toString());
                        },
                      ):SvgPicture.asset("assets/images/01Home/avatar.svg"),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.6, -1),
                    child: IconButton(
                      iconSize: 35,
                        icon: Container(
                        child: SvgPicture.asset("assets/images/01Home/btn_edit.svg"),
                      ), 
                      onPressed: () { 
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new EditPerfil()));
                       },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
            width: _width,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Resumen',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Variables.AZULCYAN
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Container(
                      width: _width,
                      child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width*0.4,
                                child: Text('Puntuacion',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width*0.4,
                                child: Text(_puntos,
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width*0.4,
                                child: Text('Mi equipo',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width*0.4,
                                child: Text(_miEquipo,
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: _width*0.4,
                                child: Text('ScorePoints',
                                  style: TextStyle(
                                    color: Variables.GRIS,
                                    fontSize: 20
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              Container(
                                width: _width*0.4,
                                child: Text(_scorePoints,
                                  style: TextStyle(
                                    color: Variables.VERDE,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 40,
                            endIndent: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                //   Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Text(
                //       'Historial',
                //       style: TextStyle(
                //         fontSize: 30,
                //         fontWeight: FontWeight.bold,
                //         color: Variables.AZULCYAN
                //       ),
                //     ),
                //   ),
                //   Column(
                //     children: [
                //       Container(
                //         child: Text(
                //           '26/07/2019',
                //           style: TextStyle(
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold,
                //             color: Variables.GRISOSCURO
                //           ),
                //         ),
                //       ),
                //       Divider(
                //         thickness: 2,
                //         indent: 40,
                //         endIndent: 40,
                //       ),
                //       Container(
                //         width: _width/1.5,
                //         child: Text(
                //           '■ Actualización de perfil',
                //           style: TextStyle(
                //             fontSize: 18,
                //             color: Variables.GRISMEDIO
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: _width/1.5,
                //         child: Text(
                //           '■ Compra de catálogo',
                //           style: TextStyle(
                //             fontSize: 18,
                //             color: Variables.GRISMEDIO
                //           ),
                //         ),
                //       ),
                //       Container(
                //         width: _width/1.5,
                //         child: Text(
                //           '■ Cargo a tarjeta',
                //           style: TextStyle(
                //             fontSize: 18,
                //             color: Variables.GRISMEDIO
                //           ),
                //         ),
                //       ),
                //     ],
                //   )
                ],
              ),
            )
          )
        ] 
      ),
    );
  }
}