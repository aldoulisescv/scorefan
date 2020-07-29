import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
class EditPerfil extends StatefulWidget {
  @override
  _EditPerfilState createState() => _EditPerfilState();
}
  
class _EditPerfilState extends State<EditPerfil> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String _userId='';
  String _authtoken='';
  String _nombre='';
  int _elementSelected=1;
  int _indexCarrousel=0;
  bool _productosCargados=false;
  HttpService http = new HttpService();
  List<dynamic> _categorias = List<dynamic>();
  Map<dynamic,dynamic>_seleccionados = Map<dynamic,dynamic>();
  Map<int,List<dynamic>> _productos =Map<int, List<dynamic>>();
  Map<dynamic,dynamic> _mapProductos =Map<dynamic, dynamic>();
    // Map<dynamic,dynamic> _productos =Map<dynamic,dynamic>();
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
  @override
  void initState() {
    super.initState();
    setState(() {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      _userId = Provider.of<LoginState>(context, listen: false).getUserId();
      _nombre = Provider.of<LoginState>(context, listen: false).getNombre();
      this.getCategories();
    });
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
        await llenaAccesorios(item['id']);
        await cargaSeleccionados(item['id']);
      }
      setState(() {
        _categorias=response['data'];
        print('_categorias');
        print(_categorias);
        _productosCargados=true;
      });
    }
  }
  Future<void> llenaAccesorios(int cat) async {
    String url =  Variables.API_URL+'/api/accessories?enabled=1&category_id='+cat.toString();
    print(url);
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    print(response);
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      setState(() {
        _productos[cat]=response['data'];
        _mapProductos[cat]=response['data'];
        print(_mapProductos);
        print(cat);
        // print(Variables.API_URL+"/storage/"+_mapProductos[1][0]['img_url']);
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
  Future<void> guardarPerfil() async {
    String url =  Variables.API_URL+'/api/guardarPerfil';
    print(url);
    String json ='[';
    _seleccionados.forEach((key, value) { 
      json +='{"categoria":"'+key.toString()+'" , "producto":"'+value.toString()+'", "user_id": "'+_userId+'"},';
    });
    json = json.substring(0, json.length - 1);
    json +=  ']';
    print(json);
     Map<String, dynamic> response  = await http.post(url, json, _authtoken);
     print(response);
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
      });
    }
  }
  Widget _appbarActions(double _width,){
    return Container(
      child: IconButton(
        iconSize: 40,
        icon: Container(
              child: SvgPicture.asset("assets/images/02Personalizar/btn_back.svg"),
            ),
        onPressed: () => Navigator.of(context).pop(),
      ), 
    );
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
            height: _height/15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 250,
              child: Stack(
                children: [
                  Container(
                    height: _height/2,
                    child: Align(
                      child: (_indexCarrousel!=0)
                        ?Container(
                          height: _height/3,
                          width: _height/3,
                          decoration: new BoxDecoration(
                            color: Variables.BLANCO,
                            shape: BoxShape.circle,
                          ),
                        )
                        :null,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.6, -1),
                    child: (_indexCarrousel!=0)
                      ?IconButton(
                        iconSize: 35,
                          icon: Container(
                          child: SvgPicture.asset("assets/images/03Jersey/btn_aceptar.svg"),
                        ), 
                        onPressed: () { 
                          setState(() {
                            _indexCarrousel = 0;
                            guardarPerfil();
                          });
                        },
                      )
                      :null,
                  ),
                  Center(
                    child: Container(
                      height: _height/2,
                      width: _width,
                      child: SvgPicture.asset("assets/images/01Home/avatar.svg"), 
                    ),
                  ),
                  for(var item in _categorias ) 
                    Container(
                      height: _height/2,
                      child: Align(
                        alignment: Alignment(item['pos_x'].toDouble(), item['pos_y'].toDouble()),
                        // alignment: Alignment(0, -0.74),
                        child: Container(
                          height: _height * (item['height'].toDouble() / 100),
                          width: _height/5,
                          // color: Variables.AZULCYAN,
                          child:(_seleccionados[item['id'].toString()]!=null)
                          ?SvgPicture.network(Variables.API_URL+"/storage/products/product_"+_seleccionados[item['id'].toString()].toString()+".svg", fit: BoxFit.fitHeight,)
                          :null,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
         Container(
            child: IndexedStack(
              index: _indexCarrousel,
              children: [
                (_categorias.length>0)?Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 1,
                      viewportFraction: 0.3,
                      height: _height/4,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _elementSelected = index;
                        });
                      },
                    ),
                    items: _categorias.map((item) => Container(
                      child: Container(
                        height: _height/4.5,
                        child: Container(
                          //sborderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  height: 100,
                                  child: SvgPicture.network(Variables.API_URL+"/storage/"+_categorias[_categorias.indexOf(item)]['img_url'], fit: BoxFit.fitHeight,),
                                ),
                                onTap: () {
                                  setState(() {
                                    _indexCarrousel=_categorias.indexOf(item)+1;
                                  });
                                },
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                                  child: (_categorias.indexOf(item)==_elementSelected)
                                    ?Text(
                                    _categorias[_categorias.indexOf(item)]['name'],
                                    style: TextStyle(
                                      color: Variables.VERDE,
                                      fontSize: _height/35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ):null,
                                ),
                            ],
                          )
                        ),
                      ),
                    )).toList(),
                  ),
                ):Center(child: CircularProgressIndicator()),
                for(var item in _categorias ) 
                Stack(
                  children:[
                    Container(
                      height: _height/4.5,
                      alignment: Alignment.center,
                      child: Container(
                        height: _height/20,
                        color: Variables.AZULLOGO,
                      ),
                    ),
                    (_productosCargados==true)?CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        initialPage: 2,
                        viewportFraction: 0.2,
                        height: _height/4.5,
                        onPageChanged: (index, reason) {
                          print(index);
                          // setState(() {
                          //   _elementSelected = index;
                          // });
                        },
                      ),
                      items:_productos[item['id']].map((item) => Container(
                        child: Container(
                          height: _height/4.5,
                          child: GestureDetector(
                            child: Container(
                              height: 130,
                              // child: Text(item.toString()),
                               child: SvgPicture.network(Variables.API_URL+"/storage/products/product_"+item['product_id'].toString()+".svg", fit: BoxFit.fitWidth,),
                            ),
                            onTap: () {
                              print(item.toString());
                              setState(() {
                                _seleccionados[item['category_id'].toString()] = item['product_id'];
                                print(_seleccionados);
                              });
                            },
                          )
                        ),
                      )).toList()
                    ):Center(child: CircularProgressIndicator()),
                  ] 
                ),
              ],
            )
          ),
        ] 
      ),
    );
  }
}