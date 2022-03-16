import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  static const String id = "location_screen";

  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/data.json");
    final jsonResult = jsonDecode(data);
    print(jsonResult);

    for (int i = 0; i < jsonResult["locations"].length; i++) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("id-$i"),
            position: LatLng(
              double.parse(jsonResult["locations"][i]["latitude"]),
              double.parse(jsonResult["locations"][i]["longitude"]),
            ),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: jsonResult["locations"][i]["name"],
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.031698, 72.472894),
          zoom: 15,
        ),
      ),
    );
  }
}
