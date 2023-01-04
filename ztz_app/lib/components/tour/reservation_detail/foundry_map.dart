
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';

class FoundryMap extends StatefulWidget {
  const FoundryMap({Key? key,
  required this.lat,
  required this.lng,
  required this.name,
  }) : super(key: key);

  final double lat, lng;
  final String name;

  @override
  State<FoundryMap> createState() => FoundryMapState();
}

class FoundryMapState extends State<FoundryMap> {
  Completer<GoogleMapController> _controller = Completer();

  static late CameraPosition _kGooglePlex;

  late LatLng _kMapCenter;

  @override
  void initState() {
    super.initState();

    _kGooglePlex = CameraPosition(
      target:  LatLng( widget.lat , widget.lng ),
      zoom: 17,
    );

    _kMapCenter = LatLng( widget.lat , widget.lng);
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("marker_1"),
        position: _kMapCenter,
        infoWindow: InfoWindow(
          title: widget.name,
        ),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        markers: _createMarker(),

        onCameraMove: (CameraPosition cameraPosition){},
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        compassEnabled: true,
        padding: EdgeInsets.only(
            bottom:MediaQuery.of(context).size.height*0.25),

        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}