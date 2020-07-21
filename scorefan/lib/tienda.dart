// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/productos.dart';

class Tienda extends StatefulWidget {
  @override
  _TiendaState createState() => _TiendaState();
}

class _TiendaState extends State<Tienda> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  HttpService http = new HttpService();
  String _authtoken='';
  List< dynamic> _categorias = List< dynamic>();


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
  Future<void> getCategories() async {
    String url =  Variables.API_URL+'/api/categories?enabled=1';
    Map<String, dynamic> response = await http.get(url, _authtoken);  
    if(response['ex']!=null){
      _globalKey.currentState.showSnackBar(
        SnackBar(
          content: Text(response['ex']),
          backgroundColor: Colors.red,
        )
      );
    }else{
      await new Future.delayed(const Duration(seconds : 1));
      setState(() {
        _categorias = response['data'];
        print(_categorias);
        print(_categorias[0]['name']);
      });
      
    }
  }
  void initState() {

    super.initState();
    setState(()  {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      this.getCategories();
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
          body: 
          Container(
            width: _width,
            height: _height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Tienda',
                    style: TextStyle(
                      color: Variables.AZULOSCURO,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
               (_categorias.isNotEmpty)?  Expanded(
                  child: ListView.builder( 
                    itemCount: _categorias.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(Variables.API_URL+"/storage/"+_categorias[index]['img_url']);
                       return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:20.0),
                            child: InkWell(
                               onTap: () {
                                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new Productos(_categorias[index]['id'].toString(), _categorias[index]['name'].toString())));
                                },
                              child: Column(
                                children: [
                                  Container(
                                    height: _height/5,
                                    width: _width/2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.network(Variables.API_URL+"/storage/"+_categorias[index]['img_url'], fit: BoxFit.fitHeight,),
                                    ),
                                  ),
                                  Center(
                                    child: Text(_categorias[index]['name'],
                                      style: TextStyle(
                                        color: Variables.AZULOSCURO,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                       );
                    },
                  ),
                ):Center(child: CircularProgressIndicator(),)
              ],
                )
            )

          // ListView(
          //   children: [
          //    
          //     InkWell(
          //      
          //       child: Container(
          //         child: Column(
          //           children: [
          //             Container(
          //               height: _height/4,
          //               width: _width/2,
          //               child: SvgPicture.asset("assets/images/04Tienda/100sp.svg", fit: BoxFit.fitWidth,),
          //             ),
          //              Center(
          //               child: Text('ScoreSaldo',
          //                 style: TextStyle(
          //                   color: Variables.AZULOSCURO,
          //                   fontSize: 30,
          //                   fontWeight: FontWeight.bold
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Container(
          //       child: Column(
          //         children: [
          //           Container(
          //             height: _height/4,
          //             width: _width/2,
          //             child: SvgPicture.asset("assets/images/04Tienda/jersey.svg", fit: BoxFit.fitWidth,),
          //           ),
          //            Center(
          //             child: Text('Jersey',
          //               style: TextStyle(
          //                 color: Variables.AZULOSCURO,
          //                 fontSize: 30,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       child: Column(
          //         children: [
          //           Container(
          //             height: _height/4,
          //             width: _width/2,
          //             decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/04Tienda/balon.png"), fit: BoxFit.fill)),
          //             // child: SvgPicture.asset("assets/images/04Tienda/100sp.svg", fit: BoxFit.fitWidth,),
          //           ),
          //            Center(
          //             child: Text('Balones',
          //               style: TextStyle(
          //                 color: Variables.AZULOSCURO,
          //                 fontSize: 30,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
    );
  }
}