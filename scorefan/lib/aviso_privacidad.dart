import 'package:flutter/material.dart';
import 'package:scorefan/classes/variables.dart';
// import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
class AvisoPrivacidad extends StatefulWidget {
  @override
  _AvisoPrivacidadState createState() => _AvisoPrivacidadState();
}

class _AvisoPrivacidadState extends State<AvisoPrivacidad> {
  // bool _isLoading = true;
  String pdfFileurl = Variables.API_URL+"/storage/aviso_privacidad.pdf";
  // PDFDocument _document;
  @override
  void initState() {
    super.initState();
    loadDocument();
  }
  loadDocument() async {
    // _document = await PDFDocument.fromURL(pdfFileurl);

    // setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Términos y condiciones'),
        backgroundColor: Variables.AZULCLARO,
      ),
        body: Center(
            // child: _isLoading
            //   ? Center(child: CircularProgressIndicator())
            //   : PDFViewer(document: _document,
            //   showPicker: false,
          // )
        ),
      );
  }
}