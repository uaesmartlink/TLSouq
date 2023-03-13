import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  LatLng initialPosition;
  Position position;

  MapSample({
    Key? key,
    required this.initialPosition,
    required this.position,
  }) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  List<Marker> markers = [];

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    widget.position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      widget.initialPosition =
          LatLng(widget.position.latitude, widget.position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    markers[0] = Marker(
      position: widget.initialPosition,
      markerId: MarkerId(widget.position.toString()),
    );
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: widget.initialPosition,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(markers),
        onLongPress: _handleTap,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          child: Icon(Icons.my_location_outlined),
          //child widget inside this button
          onPressed: () {
            _goToTheLake();
            //task to execute when this button is pressed
          },
        ),
      ),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      markers = [];
      markers.add(
        Marker(
          position: point,
          markerId: MarkerId(point.toString()),
        ),
      );
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: widget.initialPosition,
      zoom: 20,
    )));
  }
}
