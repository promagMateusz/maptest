import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_test/home_page_deviceview.dart';

class AddressForm extends ConsumerStatefulWidget {
    const AddressForm({Key? key}) : super(key: key);

    @override
    ConsumerState<ConsumerStatefulWidget> createState() => _AddressForm();
}

class _AddressForm extends ConsumerState<AddressForm> {
    
    final TextEditingController addressInput = TextEditingController();
    final TextEditingController cityInput = TextEditingController();

    @override
    Widget build(BuildContext context){
        return ListView(
            padding: const EdgeInsets.only(right: 15, left: 15),
            children: [
                Form(
                    child: Column(
                        children:  [
                          TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Address Line',
                                icon: Icon(Icons.home),
                              ),
                              controller: addressInput,
                          ),
                          TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'City',
                                icon: Icon(Icons.location_city),
                              ),
                              controller: cityInput,
                          ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    ref.read(markerProvider).addAddress(addressInput.text, cityInput.text);
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Processing Data")),
                                    );
                                  },
                                  child: const Text('Submit'),
                              ),
                          ),
                        ],
                    ),
                )]
        );
    }
}