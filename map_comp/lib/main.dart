//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Map component"),
        ),
        body: Map(),

      )
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  GoogleMapController mapController;// to get further info about the implemented map
  static const _initialPos = LatLng(-37.7384855,144.7228);
  LatLng currLocation;
  LatLng _lastPos = _initialPos;
  final Set<Marker> _markers = {}; // to save markers of the map



  @override
  Widget build(BuildContext context) {
    Stack(
      children: <Widget>[
        GoogleMap(initialCameraPosition: CameraPosition(target: _initialPos,
            zoom:10.0),
          onMapCreated: onCreateMap, // update the state once the map is created
          myLocationEnabled: true,
          mapType: MapType.normal,
          compassEnabled: true, // directions
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        Positioned(
          top: 40.0,
          left: 10.0,
          child: FloatingActionButton(onPressed: _addMarker,
              tooltip: "Add marker",
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.fastfood , color: Colors.white70,) ,

              )


        )
      ],
    );
  }

  void onCreateMap(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _addMarker() {
  setState(() {
    _markers.add(Marker(markerId: MarkerId(_lastPos.toString(),),
      position: _lastPos,
      infoWindow: InfoWindow(
        title: "Marked!!",
        snippet: "pop",
      ),
        icon: BitmapDescriptor.defaultMarker
    )
    );
  });
  }

  void _onCameraMove(CameraPosition position) {
_lastPos = position.target;
  }

}

