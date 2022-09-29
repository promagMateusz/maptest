import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/home_page_deviceview.dart';
import 'package:map_test/map_helper.dart';
import 'package:map_test/map_marker.dart';
import 'package:fluster/fluster.dart';
import 'dart:io';
import 'package:auto_route/auto_route.dart';

class MyMap extends ConsumerStatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyMap();
}

GoogleMapController? mapController;
CameraPosition goog =
    const CameraPosition(target: LatLng(49.031212, -122.861801), zoom: 13);
bool isIdleAfterZoom = false;

class _MyMap extends ConsumerState<MyMap> {
  @override
  Widget build(BuildContext context) {
    final markers = ref.watch(markerProvider);
    final currentPosition = ref.watch(currentMapPositionProvider);

    mapController?.moveCamera(
        CameraUpdate.newCameraPosition(currentPosition.currentPosition));

    Fluster<MapMarker> cluster =
        MapHelper.initClusterManager(markers.getMarkers, 0, 20);

    return SizedBox(
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: currentPosition.currentPosition,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
        onCameraIdle: () {
          if (isIdleAfterZoom == true) {
            isIdleAfterZoom = false;
            currentPosition.refresh();
          }
        },
        onCameraMove: (CameraPosition position) {
          if (position.zoom != currentPosition.currentPosition.zoom) {
            ref
                .read(currentMapPositionProvider)
                .changeCurrentPosition(position);
            isIdleAfterZoom = true;
          }
          ref.read(currentMapPositionProvider).changeCurrentPosition(position);
        },
        markers: MapHelper.getGoogleMapsMarkers(
                cluster, currentPosition.currentPosition)
            .toSet(),
        onLongPress: ref.read(markerProvider).addMarker,
      ),
    );
  }
}

// Test this // Todo Later
LatLng centeredCameraPosition(ref) {
  final markers = ref.watch(markerProvider);
  final Set<LatLng> latLngSet = markers.getLatLngSet;
  if (latLngSet.isEmpty == true) {
    // Change this to something else later
    return const LatLng(49.031212, -122.861801);
  }
  double totalLat = 0;
  double totalLong = 0;
  for (var value in latLngSet) {
    totalLat += value.latitude;
    totalLong += value.longitude;
  }
  final double centeredLat = totalLat / latLngSet.length;
  final double centeredLong = totalLong / latLngSet.length;
  return LatLng(centeredLat, centeredLong);
}
