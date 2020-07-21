// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:scorefan/classes/drawer.dart';
import 'package:scorefan/classes/appbar.dart';
import 'package:scorefan/classes/http_service.dart';
import 'package:scorefan/classes/login_state.dart';
import 'package:scorefan/classes/variables.dart';
import 'package:scorefan/confirma_compra.dart';

class Productos extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  const Productos(this.categoryId, this.categoryName);
  
  @override
  _ProductosState createState() => new _ProductosState();
}

class _ProductosState extends State<Productos> {
  
  String _authtoken='';
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  HttpService http = new HttpService();
  List< dynamic> _productos = List< dynamic>();


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
  Future<void> getProducts() async {
    String url =  Variables.API_URL+'/api/products?enabled=1&category_id='+widget.categoryId;
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
      await new Future.delayed(const Duration(seconds : 1));
      setState(() {
        _productos = response['data'];
      });
      
    }
  }
  @override
  void initState() {
    super.initState();
    print('categori: '+widget.categoryName);
    setState(() {
      _authtoken = Provider.of<LoginState>(context, listen: false).getAuthToken();
      this.getProducts();
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
          body: Container(
            width: _width,
            height: _height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(widget.categoryName,
                    style: TextStyle(
                      color: Variables.AZULOSCURO,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                (_productos.isNotEmpty)?  Expanded(
                  child: ListView.builder( 
                    itemCount: _productos.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(Variables.API_URL+"/storage/"+_productos[index]['img_url']);
                       return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new ConfirmaCompra( _productos[index]['id'].toString() , _productos[index]['name'] )));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: _height/5,
                                    width: _width/2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.network(Variables.API_URL+"/storage/"+_productos[index]['img_url'], fit: BoxFit.fitHeight,),
                                    ),
                                  ),
                                  Center(
                                    child: Text(_productos[index]['name'],
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
            ),
          ),
          // ListView(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Center(
          //         child: Text(widget.categoryName,
          //         style: TextStyle(
          //           color: Variables.AZULOSCURO,
          //           fontSize: 30,
          //           fontWeight: FontWeight.bold
          //           ),
          //         ),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>new ConfirmaCompra()));
          //       },
          //       child: Container(
          //         child: Column(
          //           children: [
          //             Container(
          //               height: _height/4,
          //               width: _width/2,
          //               child: SvgPicture.asset("assets/images/05ScorePoints/100sp.svg", fit: BoxFit.fitWidth,),
          //             ),
          //              Center(
          //               child: Text('100ss',
          //                 style: TextStyle(
          //                   color: Variables.AZULOSCURO,
          //                   fontSize: 35,
          //                   fontWeight: FontWeight.bold
          //                 ),
          //               ),
          //             ),
          //             Center(
          //               child: Text("\$ 150.00",
          //                 style: TextStyle(
          //                   color: Variables.VERDE,
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
          //             child: SvgPicture.asset("assets/images/05ScorePoints/200sp.svg", fit: BoxFit.fitWidth,),
          //           ),
          //             Center(
          //             child: Text('200ss',
          //               style: TextStyle(
          //                 color: Variables.AZULOSCURO,
          //                 fontSize: 35,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //           Center(
          //             child: Text("\$ 200.00",
          //               style: TextStyle(
          //                 color: Variables.VERDE,
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
          //             child: SvgPicture.asset("assets/images/05ScorePoints/300sp.svg", fit: BoxFit.fitWidth,),
          //           ),
          //             Center(
          //             child: Text('100ss',
          //               style: TextStyle(
          //                 color: Variables.AZULOSCURO,
          //                 fontSize: 35,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //           Center(
          //             child: Text("\$ 250.00",
          //               style: TextStyle(
          //                 color: Variables.VERDE,
          //                 fontSize: 30,
          //                 fontWeight: FontWeight.bold
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
    
    );
  }
}