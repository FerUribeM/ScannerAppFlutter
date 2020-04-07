import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:scannerapp/src/pages/directions_page.dart';
import 'package:scannerapp/src/pages/maps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QA Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {})
        ],
      ),
      body: _callPage(currentPage),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scannQR,
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: _createBottonNavigator(),
    );
  }

  void _scannQR() async{
    String codeResult = '';
    try{
      codeResult = await BarcodeScanner.scan();
    }catch(e){
      print('Error ${e.toString()}');
    }

    print('Resultado ${codeResult}');

  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapsPage();
      case 1:
        return DirectionsPage();
      default:
        return MapsPage();
    }
  }

  BottomNavigationBar _createBottonNavigator() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
      },
      items: [
        BottomNavigationBarItem(title: Text('Mapas'), icon: Icon(Icons.map)),
        BottomNavigationBarItem(
            title: Text('Direcciones'), icon: Icon(Icons.brightness_5)),
      ],
    );
  }
}
