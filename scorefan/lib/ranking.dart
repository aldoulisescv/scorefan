import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';

class Ranking extends StatefulWidget {
  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String _authtoken='';
  HttpService http = new HttpService();
  List<dynamic> _ranking = List<dynamic>();
  int comprando = 0;
  String _userId='';
  bool _cargandoRanking = true;

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
                  height: 50,
                  width: 70,
                  child: SvgPicture.asset("assets/images/02Personalizar/btn_back.svg"),
                ),
            onPressed: () => Navigator.of(context).pop(),
          ), 
        );
              
  }
  Widget _rank(double _width, double _height, String _posicion,String _cambio,Color _colorCambio, String _urlImage, String _nombre,  String _puntos, String _userId, Color _color){
   return Padding(
      padding: const EdgeInsets.only(left:8.0, right: 6),
      child: Container(
        width: _width,
        decoration: new BoxDecoration(
          color: _color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: _width/12,
                    width: _width/6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          _posicion,
                          style: TextStyle(
                            color: Variables.BLANCO,
                            fontSize: 20
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: _width/12,
                          width: _width/12,
                          child: AutoSizeText(
                            _cambio,
                            style: TextStyle(
                              color: _colorCambio,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _width/2.5,
                    height: _width/12,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: _width/12,
                          width: _width/10,
                          child:Image.network(_urlImage)
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: _width/12,
                          // width: _width/12,
                          child: AutoSizeText(
                            _nombre,
                            style: TextStyle(
                              color: Variables.BLANCO,
                              fontSize: 15
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                    height: _width/12,
                    width: _width/6,
                    child: AutoSizeText(
                      _puntos,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: _width/12,
                    width: _width/6,
                    child: InkWell(
                      child: Icon(
                          Icons.visibility,
                          color: Variables.AZULCLARO,
                      ),
                      onTap: () async{
                         await _asyncVer(context,
                          _width, 
                          _nombre, 
                          _userId,
                          _urlImage);
                      },
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
                      
  }
  Future<void> getRanking() async {
    String url =  Variables.API_URL+'/api/rank';
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      ).closed.then((SnackBarClosedReason reason) {
          setState(() {
            _cargandoRanking = false;
          });
      });
    }else{
      setState(() {
        _ranking=response['data'];
        _cargandoRanking = false;
      });
    }
  }
  void cargando(int band) {
    setState(() {
      comprando=band;
     print(comprando);
    });
  }
  Future<void> _verResultados(String _userId) async {
     String url =  Variables.API_URL+'/api/guardarCompra';
      print(url);
      String json = '{"product_id": "8", "user_id": "'+_userId+'" }';
      print(json);
      Map<String, dynamic> response  = await http.post(url, json, _authtoken);
      await new Future.delayed(const Duration(seconds : 3));
        
      Navigator.of(context).pop('');

      if(response['ex']!=null){
        
        _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response['ex']),
            backgroundColor: Variables.ROJO,
          )
        );
      }else{
        _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response['data']),
            backgroundColor: Variables.VERDE,
          )
        ).closed.then((SnackBarClosedReason reason) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            // Navigator.pop(context);
        });
        
      }
  }
  Future<void> getResumen() async {
    String url =  Variables.API_URL+'/api/resumen/'+_userId;
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Variables.ROJO,
        )
      );
    }else{
       if( response['data']['balance']>=200){
         _verResultados(_userId);
       }else{
          Navigator.of(context).pop('');
        _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Score Saldo Insuficiente'),
            backgroundColor: Variables.ROJO,
          )
        );
       }
    }
  }
   Future<String> _dialogCargando(BuildContext context) {
    
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) { 
        return Dialog(
          backgroundColor: Variables.TRANSPARENTE,
          child: Container(
            child: Center(child: CircularProgressIndicator()),
            height: 100,
            width: 100,
            ),
        );
      }
    );
 }

  Future<String> _asyncVer(BuildContext context, double _width,String _name, String _userId, String _urlImage) {
    
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) { 
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color:Variables.AZULCYAN,
                width: 2
              ),
              color: Variables.AZULOSCURO,
            ),
            height: 250,
            width: _width/1.3,
            child: Stack(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,20,0,8),
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Variables.BLANCO,
                          ),
                          height: 70.0,
                          width: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(_urlImage),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 35,
                        child: AutoSizeText(
                          _name,
                          style:TextStyle(
                            color: Variables.AZULCYAN,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          )
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        AutoSizeText(
                          'Ver los Resultados',
                          style: TextStyle(
                            fontSize: 15,
                            color: Variables.BLANCO
                          ),
                        ),
                        AutoSizeText('Te costará:',
                          style: TextStyle(
                            fontSize: 15,
                            color: Variables.BLANCO
                          ),
                        ),
                        AutoSizeText('200SP',
                          style: TextStyle(
                            fontSize: 25,
                            color: Variables.BLANCO,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    ],
                ), 
                Align(
                  alignment: Alignment(0, 1.25),
                  child: Container(
                    height: 50,
                    width: _width/2.5,
                    child: (comprando==0)? RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop('');
                        _dialogCargando(context);
                        getResumen();
                      },
                      color: Variables.AZULCYAN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child:Text(
                        "Aceptar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ):Center(child: CircularProgressIndicator()),
                  ),
                ),
                Align(
                  alignment: Alignment(0.9, -0.9),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop('');
                    },
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Variables.GRIS,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
 }
   
   @override
  void initState() {
    super.initState();
    setState(()  {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      _userId = Provider.of<LoginState>(context, listen: false).getUserId();
      this.getRanking();
    });
  }
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return  Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Variables.GRIS,
          appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
          drawer: elDrawer(context,_globalKey, _width, _height),
          body: ListView(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Ranking',
                    style: TextStyle(
                      color: Variables.AZULOSCURO,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
                width: _width,
                height: _height + 38,
                child: Column(
                  children:[
                    Padding(
                      padding: const EdgeInsets.only(top:12.0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: _width/6,
                            height: _width/12,
                            alignment: Alignment.bottomCenter,
                            child: AutoSizeText(
                              'Posición',
                              style: TextStyle(
                                fontSize: 12,
                                color: Variables.AZULCYAN,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/2.5,
                            height: _width/12,
                            alignment: Alignment.bottomCenter,
                            child: AutoSizeText(
                              'Nombre',
                              style: TextStyle(
                                fontSize: 12,
                                color: Variables.AZULCYAN,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/6,
                            height: _width/12,
                            alignment: Alignment.bottomCenter,
                            child: AutoSizeText(
                              'Puntos',
                              style: TextStyle(
                                fontSize: 12,
                                color: Variables.AZULCYAN,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/6,
                            height: _width/12,
                            alignment: Alignment.bottomCenter,
                            child: AutoSizeText(
                              'Stats',
                              style: TextStyle(
                                fontSize: 12,
                                color: Variables.AZULCYAN,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        (!_cargandoRanking)?
                         Column(
                          children: [
                            for (var item in _ranking) 
                            
                              _rank(_width, _height,
                                item['position'].toString(),
                                (item['cambio'].toString()=='=')?'-':((item['cambio'].toString()=='>')?'↑':'↓' ),
                                (item['cambio'].toString()=='=')?Variables.BLANCO:((item['cambio'].toString()=='>')?Variables.VERDE:Variables.ROJO ),
                                Variables.API_URL+"/storage/avatars/avatar_"+item['user_id'].toString()+".png",
                                item['name'].toString(),
                                item['points'].toString(),
                                item['user_id'].toString(),
                                (_ranking.indexOf(item)%2!=0)?Variables.AZULOSCUROTRANSPARENTE:null
                                )
                                ,
                              
                          ],
                        ):Center(child:CircularProgressIndicator())
                        ],
                    )
                  
                  ]
                ),
              )
            ],
          ),
    );
  }
}