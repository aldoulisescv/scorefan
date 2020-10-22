import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';

class Estadisticas extends StatefulWidget {
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String _authtoken='';
  HttpService http = new HttpService();
  List<dynamic> _estadisticas = List<dynamic>();

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
  Widget _estadisticasEquipo(double _width, double _height, String _urlEquipo, String _ganados, String _empatados, String _perdidos, String _jugados, String _puntos, Color _color){
    print(_urlEquipo);
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
                    height: _width/12,
                    width: _width/12,
                    child:Image.network(_urlEquipo)
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: _width/12,
                    width: _width/12,
                    child: AutoSizeText(
                      _jugados,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: _width/12,
                    width: _width/12,
                    child: AutoSizeText(
                      _ganados,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                    height: _width/12,
                    width: _width/12,
                    child: AutoSizeText(
                      _empatados,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontSize: 20
                      ),
                    ),
                  ),
                  
                  Container(
                      alignment: Alignment.center,
                    height: _width/12,
                    width: _width/12,
                    child: AutoSizeText(
                      _perdidos,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontSize: 20
                      ),
                    ),
                  ),

                  Container(
                      alignment: Alignment.center,
                    height: _width/12,
                    width: _width/12,
                    child: AutoSizeText(
                      _puntos,
                      style: TextStyle(
                        color: Variables.BLANCO,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
                      
  }
  Future<void> getEstadisticas() async {
    String url =  Variables.API_URL+'/api/tabla';
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
        _estadisticas=response['data'];
        print('_estadisticas');
        print(_estadisticas);
      });
    }
  }
   @override
  void initState() {
    super.initState();
    setState(()  {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      this.getEstadisticas();
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
                    child: Text('Estadísticas',
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
                      padding: const EdgeInsets.only(top:18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: _width/12,
                            height: _width/12,
                          ),
                          Container(
                            width: _width/12,
                            height: _width/12,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.AZULCLARO,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'PJ',
                              style: TextStyle(
                                fontSize: 17,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/12,
                            height: _width/12,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.VERDE,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'PG',
                              style: TextStyle(
                                fontSize: 17,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/12,
                            height: _width/12,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.GRIS,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'PE',
                              style: TextStyle(
                                fontSize: 17,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/12,
                            height: _width/12,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.ROJO,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'PP',
                              style: TextStyle(
                                fontSize: 17,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            width: _width/12,
                            height: _width/12,
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                              color: Variables.GRISMEDIO,
                              shape: BoxShape.circle,
                            ),
                            child: AutoSizeText(
                              'Pts',
                              style: TextStyle(
                                fontSize: 17,
                                color: Variables.AZULOSCURO,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        
                        Container(
                          height: _height/1.2,
                          width: _width,
                          child: Row(
                            children: [
                              SizedBox(
                                width: _width/6,
                                height: _width/6,
                              ),
                              Container(
                                width:_width - _width/6,
                                child: Row(
                                  children: [
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/9,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/9,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/9,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(
                                      width: _width/9,
                                      height: _width/9,
                                    ),
                                    VerticalDivider(
                                      thickness: 2,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            for (var item in _estadisticas) 
                              _estadisticasEquipo(_width, _height,
                                Variables.API_URL+"/storage/teams/team_"+item['id'].toString()+".png",
                                (item['PG'] +item['PE']+item['PP']).toString(),
                                item['PG'].toString(),
                                item['PE'].toString(),
                                item['PP'].toString(),
                                item['puntos'].toString(),
                                (_estadisticas.indexOf(item)%2==0)?Variables.AZULOSCUROTRANSPARENTE:null
                                )
                                ,
                            
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/pachuca.png", "3", "2", "4"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/leon.png", "4", "0", "7"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/tigres.png", "6", "0", "1"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/monterrey.png", "5", "3", "2"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/cruzazul.png", "3", "4", "1"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/america.png", "6", "0", "1"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/necaxa.png", "3", "4", "1"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/tijuana.png", "5", "3", "2"),
                            // _estadisticasEquipo(_width, _height, "assets/images/11Estadisticas/toluca.png", "6", "0", "1"),
                          ],
                        ),
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