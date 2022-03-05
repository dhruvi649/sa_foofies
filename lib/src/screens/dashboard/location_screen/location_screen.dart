import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  final Set<Marker> _marker = {};
  late GoogleMapController controllers;

  void _onMapCreated(GoogleMapController controller) async {
    controllers=controller;
    String data =
    await DefaultAssetBundle.of(context).loadString('asset/data.json');
    final jsonResult = jsonDecode(data);
    print('$jsonResult');

    for (int i = 0; i < jsonResult["location"].length; i++) {
      setState(() {
        _marker.add(
          Marker(
            icon: BitmapDescriptor.defaultMarker,
            markerId: MarkerId("id-$i"),
            position: LatLng(
              double.parse(jsonResult["location"][i]["latitude"]),
              double.parse(jsonResult["location"][i]["longitude"]),
            ),
           infoWindow: InfoWindow(title: jsonResult["location"][i]["name"]),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _marker,
        initialCameraPosition: CameraPosition(target: LatLng(23.031698, 72.472894),
            zoom: 15)),

    );
  }


}