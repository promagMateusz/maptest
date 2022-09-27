import 'package:flutter/material.dart';
import 'package:map_test/map.dart';
import 'package:map_test/large_map_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/providers/marker_provider.dart';
import 'package:map_test/providers/camera_position_provider.dart';

final markerProvider = ChangeNotifierProvider<MarkerStateNotifier>((ref) => MarkerStateNotifier());
final currentMapPositionProvider = ChangeNotifierProvider<CurrentPositionStateNotifier>((ref) => CurrentPositionStateNotifier());

class DeviceOverview extends ConsumerStatefulWidget {
    const DeviceOverview({Key? key}) : super(key: key);
    
    @override
    ConsumerState<ConsumerStatefulWidget> createState() => _DeviceOverviewState();
}
class _DeviceOverviewState extends ConsumerState<DeviceOverview> {
  @override
  Widget build(BuildContext context){
    
    return Stack( children: [
        Container(
            padding: const EdgeInsets.all(15),
            height: 400, //temp val
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
                child: Stack( children: const [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                        ),
                        child: MyMap(),
                    ),
                    
                ]),
            ),
            
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Column(children: [
                    IconButton(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.topRight,
                    onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const LargeMap() )
                        );
                    },
                    icon: const Icon(Icons.zoom_out_map, color: Color.fromARGB(164, 0, 0, 0)),
                    iconSize: 35,
                    ),
                    IconButton(
                        onPressed: (){
                            mapController?.animateCamera( 
                                CameraUpdate.newCameraPosition(
                                      CameraPosition(target: centeredCameraPosition(ref), zoom: 13), //fix cetnerCameraPosition
                                )
                            );
                        }, 
                        icon: const Icon(Icons.explore, color: Colors.black54),
                    ),
                    
                    
                ]),    
            ],
        ),
    ]);
  }
}