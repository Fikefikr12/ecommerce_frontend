import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;

  static const LatLng defaultLocation = LatLng(9.018, 38.747);

  void _onMapTap(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
  }

  void _confirmLocation() {
    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location on the map')),
      );
      return;
    }

    Navigator.pop(context, selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: Text("Pick Location"), showBackArrow: true),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: defaultLocation,
          zoom: 15,
        ),

        onMapCreated: (controller) {
          mapController = controller;
        },
        onTap: _onMapTap,

        markers: selectedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('selected-location'),
                  position: selectedLocation!,
                ),
              },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmLocation,
        label: Text("Confirm Location"),
        icon: Icon(Icons.check),
      ),
    );
  }
}
