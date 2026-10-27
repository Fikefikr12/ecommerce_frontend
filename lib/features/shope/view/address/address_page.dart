import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/constants/app.colors.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:ecommerce_frontend/features/shope/view/address/Widgets/add_new_address.dart';
import 'package:ecommerce_frontend/features/shope/view/address/Widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  void initState() {
    super.initState();
    context.read<ShopeBloc>().add(GetAllAddressAdmin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewAddress()),
          );
        },
        backgroundColor: AppColor.primary,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: CustomAppbar(
        showBackArrow: true,
        title: Text('Addresses', style: TextStyle(color: Colors.black)),
      ),
      body: BlocBuilder<ShopeBloc, ShopeState>(
        builder: (context, state) {
          // Loading
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: state.addresses.length,
            itemBuilder: (context, index) {
              final address = state.addresses[index];
              return SingleAddress(address: address);
            },
          );
        },
      ),
    );
  }
}
