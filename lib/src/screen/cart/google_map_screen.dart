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
    markers.add(Marker(
      position: widget.initialPosition,
      markerId: MarkerId(widget.position.toString()),
    ));
    print("Location");
    print(widget.initialPosition);
    print(widget.position.toString());
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: Column(children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition,
              zoom: 16,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: Set.from(markers),
            onLongPress: _handleTap,
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 15, top: 10, right: 10),
          height: 80,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    _goToTheLake();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.my_location_rounded),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "LOCATE ME",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      // backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "CONFIRM LOCATION",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      markers[0] = Marker(
        position: point,
        markerId: MarkerId(point.toString()),
      );
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: widget.initialPosition,
      zoom: 18,
    )));
  }
}
