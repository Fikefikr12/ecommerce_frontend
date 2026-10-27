import 'package:ecommerce_frontend/core/service/auth_service.dart';
import 'package:ecommerce_frontend/core/util/common/widgets/custom_appbar.dart';
import 'package:ecommerce_frontend/core/util/validators/validation.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_bloc.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_event.dart';
import 'package:ecommerce_frontend/features/shope/bloc/shope_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final currentUser = context.read<ShopeBloc>().state.currentUser;

    nameController.text = currentUser?.name ?? '';
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopeBloc, ShopeState>(
      builder: (context, state) {
        final currentUser = state.currentUser;
        return Scaffold(
          appBar: CustomAppbar(
            showBackArrow: true,
            title: Text(
              "Change Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User real name for easy verification,This name will apper on several pages.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 24),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        expands: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Full Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: MyValidator.validateName,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          if (currentUser == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("User not loaded")),
                            );
                            return;
                          }

                          final updatedUser = currentUser.copyWith(
                            name: nameController.text.trim(),
                          );

                          context.read<ShopeBloc>().add(
                            UpdateUserEvent(
                              id: currentUser.id!,
                              user: updatedUser,
                            ),
                          );

                          Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
