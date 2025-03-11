import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marcelina/shared/components/components.dart';
import 'package:marcelina/shared/styles/color.dart';
import 'package:marcelina/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isDarkMode = false;

  Widget build(BuildContext context) {
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
                      validate: (value) {},
                      label: 'Name',
                      prefix: IconBroken.Profile,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {},
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
                          value: isDarkMode,
                          onChanged: (value) {
                            isDarkMode = value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                      onTap: () {

                      },
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
                              onPressed: () {},
                              child: const Text('Save', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              onPressed: () {},
                              child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
