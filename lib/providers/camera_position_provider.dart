import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class CurrentPositionStateNotifier extends ChangeNotifier {
    CameraPosition _currentPosition = const CameraPosition(target: LatLng(49.031212,-122.861801), zoom: 14);
    CameraPosition get currentPosition => _currentPosition;

    void changeCurrentPosition(CameraPosition newCurrentPosition){
        
        _currentPosition = newCurrentPosition;
    }

    void refresh(){ 
      notifyListeners();
    }
    final currentMapPositionProvider = ChangeNotifierProvider<CurrentPositionStateNotifier>((ref) => CurrentPositionStateNotifier());
}

