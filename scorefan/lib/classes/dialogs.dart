import 'package:flutter/material.dart';

import 'package:scorefan/classes/variables.dart';

class Dialogs {

Future<String> asyncInput(BuildContext context, double _width,String _texto) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text(
                            _texto,
                            textAlign: TextAlign.center,
                            style:TextStyle(
                              color: Variables.AZULCYAN,
                              fontSize: 20,
                            )
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Variables.BLANCO,
                      ),
                      width: _width/1.4,
                      child: new TextField(
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        onChanged: (value) {
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
                      Navigator.pop(context);
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
  
}