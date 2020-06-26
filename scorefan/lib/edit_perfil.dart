import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  int _elementSelected=1;
  int _indexCarrousel=0;
  int _jerseySelected;
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
  static List<Widget> imgList = [
      Container(
        height: 100,
            child: SvgPicture.asset('assets/images/02Personalizar/glass.svg'),
          ),
      Container(
        height: 100,
        child: SvgPicture.asset('assets/images/02Personalizar/jersey.svg'),
      ),
      Container(
        height: 100,
        child: SvgPicture.asset('assets/images/02Personalizar/pants.svg'),
      ),
    ];
  static List<Widget> imgListJerseys = [
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey01.svg'),
      ),
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey02.svg'),
      ),
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey03.svg'),
      ),
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey04.svg'),
      ),
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey05.svg'),
      ),
      Container(
        height: 130,
        child: SvgPicture.asset('assets/images/03Jersey/jersey06.svg'),
      ),
  ];
  static List<String> nameList = [
      'Glass',
      'Jerseys',
      'Pants'
    ];
  

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
    final List<Widget> imageSliders = imgList.map((item) => Container(
      child: Container(
         height: _height/4.5,
        child: Container(
          //sborderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: item,
                onTap: () {
                  setState(() {
                    _indexCarrousel=imgList.indexOf(item)+1;
                  });
                },
              ),
              Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: (imgList.indexOf(item)==_elementSelected)
                    ?Text(
                    ' ${nameList[imgList.indexOf(item)]} ',
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
    )).toList();
    
    final List<Widget> imageSlidersJersey = imgListJerseys.map((item) => Container(
      child: Container(
        height: _height/4.5,
        child: GestureDetector(
          child: item,
          onTap: () {
            setState(() {
              _jerseySelected = imgListJerseys.indexOf(item)+1;
            });
          },
        )
      ),
    )).toList();
    
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
                child: Text('Jaime',
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
                            _jerseySelected=null;
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
                  Container(
                    height: _height/2,
                    child: Align(
                      alignment: Alignment(0, -0),
                      child: Container(
                        height: _height/4.8,
                        width: _height/5,
                        // color: Variables.AZULCYAN,
                        child:(_jerseySelected!=null)
                        ?SvgPicture.asset('assets/images/03Jersey/jersey0'+_jerseySelected.toString()+'.svg')
                        :null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: IndexedStack(
              index: _indexCarrousel,
              children: [
                Container(
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
                    items: imageSliders,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: _height/4.5,
                  color: Variables.AZULLOGO,
                  child: Center(child: Text('Glasess')),
                ),
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
                    CarouselSlider(
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
                      items: imageSlidersJersey,
                    ),
                  ] 
                ),
                Container(
                  width: double.infinity,
                  height: _height/4.5,
                  color: Variables.AZULLOGO,
                  child: Center(child: Text('Pants')),
                )
              ],
            )
          ),
        ] 
      ),
    );
  }
}