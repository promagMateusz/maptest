import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/map_marker.dart';

int x = 1;

class MarkerStateNotifier extends ChangeNotifier {
    final List<MapMarker> _markers = [];
    final Set<LatLng> _latLngSet = <LatLng>{};
    List<MapMarker> get getMarkers => _markers;
    Set<LatLng> get getLatLngSet => _latLngSet;

    void addMarker(LatLng pos){
        _markers.add(
            MapMarker(
                id: '$x',
                position: pos,
                icon: BitmapDescriptor.defaultMarker,
            ),
        );
        _latLngSet.add(pos);
        x++;
        notifyListeners();
    }

    void addMarkerAddAddress(LatLng pos, String address){
        // var marker = Marker(
        //     markerId: MarkerId("$x"),
        //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        //     position: pos,
        //     // icon: BitmapDescriptor.,
        //     infoWindow: InfoWindow(
        //         title: "Device $x",
        //         snippet: address,
        //     ),
        // );
        // _markers[MarkerId("$x")] = marker;
        // _latLngSet.add(pos);
        // x++;
        // notifyListeners();
    }
    
    void addAddress(String address, String city) async{
        List<Location> locations = await locationFromAddress("$address, $city");
        LatLng coords = LatLng(locations.first.latitude, locations.first.longitude);

        addMarkerAddAddress(coords,address);
    }
    final markerProvider = ChangeNotifierProvider<MarkerStateNotifier>((ref) => MarkerStateNotifier());
}