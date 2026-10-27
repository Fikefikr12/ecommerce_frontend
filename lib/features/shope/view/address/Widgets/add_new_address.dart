import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/data/model/address.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/address/Widgets/pick_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({super.key});

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _formKey = GlobalKey<FormState>();

  LatLng? selectedLocation;

  // controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final subCityController = TextEditingController();
  final countryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    subCityController.dispose();
    countryController.dispose();
  }

  void _saveAddress() {
    // validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your location on the map')),
      );

      return;
    }

    // create AddressModel
    final address = AddressModel(
      userId: '',
      name: nameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      street: streetController.text.trim(),
      city: cityController.text.trim(),
      subCity: subCityController.text.trim(),
      postalCode: postalCodeController.text.trim(),
      country: countryController.text.trim(),
      latitude: selectedLocation!.latitude,
      longitude: selectedLocation!.longitude,

      // Backend decides this
      isSelected: false,
    );
    context.read<ShopeBloc>().add(CreateAddressEvent(address: address));
  }

  Future<void> _pickLocation() async {
    final LatLng? location = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => PickLocationPage()),
    );

    if (location != null) {
      setState(() {
        selectedLocation = location;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(showBackArrow: true, title: Text("Add new Address")),
      body: BlocListener<ShopeBloc, ShopeState>(
        listener: (context, state) {
          if (!state.isLoading &&
              state.errorMessage == null &&
              state.selectedAddress != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Address Create Successfully")),
            );

            Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,

              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borderPrimary),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: 'Phone Number',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borderPrimary),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: streetController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.directions),
                            labelText: 'Street',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.borderPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: postalCodeController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.post_add),
                            labelText: 'Postal Code',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.borderPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.build),
                            labelText: 'city',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.borderPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: subCityController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.local_activity),
                            labelText: 'Sub City',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColor.borderPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.join_full),
                      labelText: 'Country',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.borderPrimary),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _pickLocation,
                      icon: Icon(Icons.location_on),
                      label: Text(
                        selectedLocation == null
                            ? 'Pick Location on Map '
                            : 'Location Selected',
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<ShopeBloc, ShopeState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state.isLoading ? null : _saveAddress,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: state.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Save'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
