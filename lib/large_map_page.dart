import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/address_form.dart';
import 'package:map_test/large_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_test/home_page_deviceview.dart';

class LargeMap extends ConsumerWidget{
    const LargeMap({Key? key}) : super(key:key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        return SafeArea(
            child: Scaffold(
                body: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                        const MyMapLarge(),
                        Column(children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                IconButton(onPressed: (){ ref.read(currentMapPositionProvider).refresh(); Navigator.pop(context, true);  }, icon: const Icon(Icons.close, color: Colors.black54)),
                                Column( children: [
                                    ElevatedButton(
                                        onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                    return const AlertDialog(
                                                        content: SizedBox(
                                                            height: 200,
                                                            width:  200,
                                                            child: AddressForm(),
                                                        ),      
                                                    );
                                                },
                                            );
                                        },
                                        child: const Text('Add Address'),
                                    ),
                                    IconButton(
                                        onPressed: (){
                                            mapControllerLarge?.animateCamera( 
                                                CameraUpdate.newCameraPosition(
                                                      CameraPosition(target: centeredCameraPosition(ref), zoom: 13),
                                                )
                                            );
                                            centeredCameraPosition(ref);
                                        }, 
                                        icon: const Icon(Icons.explore, color: Colors.black54),
                                    ),
                                ]),
                                
                                
                            ]),
                        ]),
                    ]),

                ), 
            ),
        );
    }
}