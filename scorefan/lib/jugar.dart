import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';

class Jugar extends StatefulWidget {
  @override
  _JugarState createState() => _JugarState();
}

class _JugarState extends State<Jugar> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  HttpService http = new HttpService();
  String _liga='';
  String _torneo='';
  String _jornada='';
  String _userId='';
  // ignore: non_constant_identifier_names
  String _jornada_id;
  String _authtoken='';
  String _fecha='Lunes 02 de Abril'; 
  Map<String, dynamic> _pronostico = Map<String, dynamic>();
  List< dynamic> _partidos = List< dynamic>();

  Future<void> getInfo() async {
    String url =  Variables.API_URL+'/api/actualRound';
    Map<String, dynamic> response = await http.get(url, _authtoken);   

      print('getInfo');
      print(response);
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
      setState(() {
        _liga='Sin liga';
        _torneo='Sin torneo';
        _jornada='Sin Jornada';
        _jornada_id='0';
        _fecha = 'Sin fecha';
      });
    }else{
      Map<String, dynamic> data = response['data'];
      setState(() {
        _liga=data['league_name'];
        _torneo=data['tournament_name'];
        _jornada=data['round_name'];
        _jornada_id=data['round_id'].toString();
        _fecha = data['date_time_limit'];
      });
    }
  }
  Future<dynamic> getMatches() async {
    await getInfo();
    if(_jornada_id=='0'){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('No hay partidos disponibles'),
          backgroundColor: Colors.red,
        )
      );
    }else{
      String url =  Variables.API_URL+'/api/roundMatches/'+_jornada_id;
      await new Future.delayed(const Duration(seconds : 1));
      var response = await http.get(url, _authtoken);  
      if(response['ex']!=null){
        _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(response['ex']),
            backgroundColor: Colors.red,
          )
        );
      }else{
        var data = response['data'];
        String url =  Variables.API_URL+'/api/roundPredictions/'+_jornada_id+'/'+_userId;
        var res = await http.get(url, _authtoken);  
      print(res);
        setState(() {
          if(res['data'].length>0)
            _pronostico = res['data'];
          _partidos = data;
        });
      }
    }
  }
  Future<dynamic> guardarPronosticos()  async {
    String error;
    _pronostico.forEach((key, value) async {
      String url = Variables.API_URL+'/api/predictions';
      String json = '{"state_id": "2", "user_id": "'+_userId+'", "match_id": "'+key+'", "prediction_local": "'+value['local']+'", "prediction_visitor": "'+value['visitante']+'", "points": "0" }';
      print(json);
      Map<String, dynamic> response  = await http.post(url, json, _authtoken);
      if(response['ex']!=null){
        
        error =response['ex'];
        _globalKey.currentState.showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
          )
        );
      }
    });
    await new Future.delayed(const Duration(seconds : 1));
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Se ha guardado correctamente!'),
          backgroundColor: Variables.VERDE,
        )
      ).closed.then((SnackBarClosedReason reason) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          // Navigator.pop(context);
      });
    
  }
  void initState() {

    super.initState();
    setState(()  {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      _userId = Provider.of<LoginState>(context, listen: false).getUserId();
      this.getMatches();
    });
    
  }
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
  Widget _lineaJugar(double _width, int _position, String _numero, String _urlImage1, String _urlImage2, String _score1, String _score2, String matchId, String teamLocalId, String teamVisitorId ){
    return Container(
            child: Padding(
              padding: const EdgeInsets.only(left:20, right:20, ),
              child: Container(
                // decoration: BoxDecoration(
                //   color: !_selected[_position] ? Variables.TRANSPARENTE : Variables.AZULOSCUROTRANSPARENTE,
                //   borderRadius: BorderRadius.circular(70),
                // ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Container(
                      width: _width/7,
                      height: 90,
                      child: Center(
                        child: Text(
                          _numero,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Variables.AZULCYAN
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _width/6,
                      height: 50,
                      child: InkWell(
                        onTap: () async {
                          final String input = await _asyncAnotacion(context,
                                                    _width, 
                                                    Variables.API_URL+"/storage/teams/team_"+teamLocalId+".png");
                          setState(() {
                            // 
                            if(_pronostico.containsKey(matchId)){
                              _pronostico[matchId].addAll({"local":input});
                            }else{
                              _pronostico.addAll({matchId:{"local":input}});
                            }
                          });
                        },
                        child: Image.network(_urlImage1,)),
                    ),
                    Container(
                      width: _width/4.7,
                      height: 60,
                        decoration:  BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/images/12Jugar/score.png"), 
                          fit: BoxFit.fitHeight
                        )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left:15, right:15, bottom: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                _score1,
                                style: TextStyle(
                                  color: Variables.BLANCO,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _score2,
                                style: TextStyle(
                                  color: Variables.BLANCO,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: _width/6,
                      height: 50,
                      child: InkWell(
                        onTap: () async {
                          final String input = await _asyncAnotacion(context,
                                                    _width, 
                                                    Variables.API_URL+"/storage/teams/team_"+teamVisitorId+".png");
                         
                          setState(() {
                            if(_pronostico.containsKey(matchId)){
                              _pronostico[matchId].addAll({"visitante":input});
                            }else{
                              _pronostico.addAll({matchId:{"visitante":input}});
                            }
                          });
                        },
                        child: Image.network(_urlImage2)),
                    )
                  ]
                ),
              ),
            ),
          );
                      
  }
  Future<String> _asyncAnotacion(BuildContext context, double _width,String logoUrl) {
    String respuesta = '';
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
                            child: Image.network(logoUrl),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        child: Text(
                          'Anotaciones',
                          style:TextStyle(
                            color: Variables.AZULCYAN,
                            fontSize: 20,
                          )
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Variables.BLANCO,
                      ),
                      width: _width/2.8,
                      child: new TextField(
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                        onChanged: (value) {
                          print(respuesta);
                          respuesta = value;
                        },
                      )
                    ),
                    ],
                ), 
                Align(
                  alignment: Alignment(0, 1.25),
                  child: Container(
                    height: 50,
                    width: _width/2.5,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop(respuesta);
                      },
                      color: Variables.AZULCYAN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Text(
                        "Aceptar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                    ),
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
  Widget build(BuildContext context) {

    // print(_authtoken);/
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
          resizeToAvoidBottomPadding:false,
          key: _globalKey,
          backgroundColor: Variables.GRIS,
          appBar: elAppbar(_globalKey, _width, _leadingIcon(), _appbarActions(_width)),
          drawer: elDrawer(context,_globalKey, _width, _height),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Jugar',
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
                    padding: const EdgeInsets.only(top: 15, bottom:10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Variables.AZULLOGO,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: _width/1.3,
                      height: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 110,
                            width: _width/3.5,
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Liga: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Torneo: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Jornada: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Fecha: ',
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Variables.AZULOSCURO,
                            thickness: 2,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Container(
                            height: 110,
                            width: _width/2.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _liga,
                                      style: TextStyle(
                                        color: Variables.AZULCYAN,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _torneo,
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _jornada,
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _fecha,
                                      style: TextStyle(
                                        color: Variables.BLANCO,
                                        fontSize: 13
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                    Container(
                    decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/01Home/background.png"), fit: BoxFit.fill)),
                    width: _width,
                    height: 80.toDouble() * (_partidos.length + 1),
                    padding: const EdgeInsets.only(top:10,left:0, right: 0, bottom: 8),
                    child:  (_partidos.isNotEmpty)? Column(
                      children: [
                       Expanded(
                          child: ListView.builder(  
                            itemCount: _partidos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  _lineaJugar(_width,0,'#'+_partidos[index]['id'].toString() ,
                                      Variables.API_URL+"/storage/teams/team_"+_partidos[index]['team_local_id'].toString()+".png",
                                      Variables.API_URL+"/storage/teams/team_"+_partidos[index]['team_visitor_id'].toString()+".png", 
                                      (_pronostico.containsKey(_partidos[index]['id'].toString()) 
                                      && _pronostico[_partidos[index]['id'].toString()]['local']!=null)
                                      ? _pronostico[_partidos[index]['id'].toString()]['local']
                                      :"", 
                                      (_pronostico.containsKey(_partidos[index]['id'].toString()) 
                                      && _pronostico[_partidos[index]['id'].toString()]['visitante']!=null)
                                      ? _pronostico[_partidos[index]['id'].toString()]['visitante']
                                      :"", 
                                      _partidos[index]['id'].toString(),
                                      _partidos[index]['team_local_id'].toString(),
                                      _partidos[index]['team_visitor_id'].toString()
                                  ),
                                  Divider(
                                    height: 2.0,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,0),
                          child: Container(
                            height: 50,
                            width: _width/1.3,
                            child: RaisedButton(
                              onPressed: () async {
                                await guardarPronosticos();
                              },
                              color: Variables.AZULCYAN,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "¡Jugar Combinación!",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) : Center(child: CircularProgressIndicator()),
                  ) 
                ]
              ),
            ],
          ),
    );
  }
 
}

