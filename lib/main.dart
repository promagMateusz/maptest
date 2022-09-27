import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/home_page_deviceview.dart';
void main() => runApp(const ProviderScope(child: MyApp()));


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: const [
                  DeviceOverview(),
              ]), 
          ),
      ),
      );
  }
}