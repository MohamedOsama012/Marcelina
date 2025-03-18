import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcelina/layouts/cubit/cubit.dart';
import 'package:marcelina/layouts/cubit/states.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/components/constants.dart';
import 'package:marcelina/shared/styles/color.dart';
import 'package:marcelina/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppUpdateUserSuccessState) {
          showToast(text: 'Profile updated successfully', state: ToastStates.SUCCESS);
        } else if (state is AppUpdateUserErrorState) {
          showToast(text: state.error, state: ToastStates.ERROR);
        }
      },
      builder: (BuildContext context, Object? state) {
        final cubit = AppCubit.get(context);
        final nameController = TextEditingController(text: cubit.userModel?.name);
        final phoneController = TextEditingController(text: cubit.userModel?.phone);
        return ConditionalBuilder(
          condition: state is AppUpdateUserLoadingState,
          builder: (BuildContext context) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          },
          fallback: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: CircleAvatar(
                                  radius: 50,
                                  child: Icon(
                                    IconBroken.Profile,
                                    size: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const Text(
                                'Personal Information',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: validateEmail,
                                label: 'Name',
                                prefix: IconBroken.Profile,
                              ),
                              const SizedBox(height: 10),
                              CustomTextField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: validatePhoneNo,
                                label: 'Phone',
                                prefix: IconBroken.Call,
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const Text(
                                'Settings',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Dark Mode', style: TextStyle(fontSize: 16)),
                                  Switch(
                                    value: cubit.isDark,
                                    onChanged: (value) {
                                      cubit.changeThemeMode();
                                    },
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                                        onPressed: () {
                                          final currentName = nameController.text.trim();
                                          final currentPhone = phoneController.text.trim();

                                          if (currentName != cubit.userModel?.name || currentPhone != cubit.userModel?.phone) {
                                            cubit.updateUserData(
                                              name: currentName,
                                              phone: currentPhone,
                                            );
                                          } else {
                                            showToast(text: 'No changes detected', state: ToastStates.ERROR);
                                          }
                                        },
                                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        onPressed: () {
                                          cubit.userModel =null;
                                          signOut(context);
                                        },
                                        child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
