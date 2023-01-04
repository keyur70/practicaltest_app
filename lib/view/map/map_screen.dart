import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practical_app/constant/image.dart';

class FullScreenMap extends StatefulWidget {
  final LatLng propertyLatLng;

  const FullScreenMap({super.key, required this.propertyLatLng});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  //-------------------------------------------------- Controller -----------------------------------------------------//
  late GoogleMapController _controller;

  //--------------------------------------------------- Variable --------------------------------------------------------//
  final Set<Marker> _markers = {};
  BitmapDescriptor? mapMarker;

  @override
  void initState() {
    setCustomeMarker();
    super.initState();
  }

  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      ConstImages.markerImg,
    );
  }

  //-------------------------------------------------- UI -------------------------------------------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMapView(),
    );
  }

  // Map View
  Widget _buildMapView() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: widget.propertyLatLng),
      mapType: MapType.normal,
      onMapCreated: (controller) {
        _controller = controller;
        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId("1"),
              position: widget.propertyLatLng,
              icon: mapMarker!,
            ),
          );
        });
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: widget.propertyLatLng, zoom: 16),
          ),
        );
      },
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapToolbarEnabled: false,
      markers: _markers,
    );
  }
}
