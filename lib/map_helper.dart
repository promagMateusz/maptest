import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/map_marker.dart';
import 'package:fluster/fluster.dart';

class MapHelper{
    static Fluster<MapMarker> initClusterManager(
    List<MapMarker> markers,
    int minZoom,
    int maxZoom,
  ) {
    return Fluster<MapMarker>(
      minZoom: minZoom,
      maxZoom: maxZoom,
      radius: 150,
      extent: 2048,
      nodeSize: 64,
      points: markers,
      createCluster: (
        BaseCluster? cluster,
        double? lng,
        double? lat,
      ) =>
          MapMarker(
        id: cluster!.id.toString(),
        position: LatLng(lat!, lng!),
        isCluster: cluster.isCluster,
        clusterId: cluster.id,
        pointsSize: cluster.pointsSize,
        childMarkerId: cluster.childMarkerId,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  static List<Marker> getGoogleMapsMarkers(Fluster<MapMarker> cluster, CameraPosition currentPosition){
    return cluster.clusters([-180,-85,180,85], (currentPosition.zoom).round()).map((cluster) => cluster.toMarker()).toList();
  }
}