import 'package:e_commerce/models/account/account.dart';

import '../../provider/dark_mode_provider.dart';
import '/app/constants/colors_value.dart';
import '/app/constants/validation_type.dart';
import '/app/pages/profile/widgets/action_row.dart';
import '/app/pages/profile/widgets/edit_profile_dialog.dart';
import '/app/pages/profile/widgets/personal_info_tile.dart';
import '/app/pages/profile/widgets/profile_picture_avatar.dart';
import '/app/widgets/pick_image_source.dart';
import '/config/flavor_config.dart';
import '/routes/routes.dart';

import '/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import '../../widgets/error_banner.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Image Picker
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Profile Picture
              Center(
                child: ProfilePictureAvatar(
                  photoProfileUrl: dummyAccount.photoProfileUrl,
                  isLoading: false,
                  onTapCamera: () {
                    pickImage();
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Personal Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Personal info",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 8),
              // Name
              PersonalInfoTile(
                personalInfo: 'Name',
                value: dummyAccount.fullName,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditProfileDialog(
                      title: 'Edit Your Name',
                      hintText: 'Type your name',
                      labelText: 'Name',
                      initialValue: dummyAccount.fullName,
                      fieldName: 'full_name',
                      validation: ValidationType.instance.emptyValidation,
                    ),
                  );
                },
              ),
              // Email Address
              PersonalInfoTile(
                personalInfo: 'Email',
                value: dummyAccount.emailAddress,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditProfileDialog(
                      title: 'Edit Your Email Address',
                      hintText: 'Type your Email Address',
                      labelText: 'Email Address',
                      initialValue: dummyAccount.emailAddress,
                      fieldName: 'email_address',
                      validation: ValidationType.instance.emailValidation,
                    ),
                  );
                },
              ),
              // Phone Number
              PersonalInfoTile(
                personalInfo: 'Phone',
                value: dummyAccount.phoneNumber.separateCountryCode(),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => EditProfileDialog(
                      title: 'Edit Your Phone Number',
                      hintText: 'Type your Phone Number',
                      labelText: 'Phone Number',
                      initialValue: dummyAccount.phoneNumber,
                      fieldName: 'phone_number',
                      validation: ValidationType.instance.emptyValidation,
                      isPhone: true,
                    ),
                  );
                },
              ),

              // Action
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Action",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 8),

              // Reset Password
              ActionRow(
                label: 'Reset Password',
                onTap: () {
                  resetPassword(emailAddress: dummyAccount.emailAddress);
                },
              ),
              const Divider(height: 1),

              // Manage Adress
              if (flavor.flavor == Flavor.user)
                ActionRow(
                  label: 'Manage Address',
                  onTap: () {
                    NavigateRoute.toManageAddress(context: context);
                  },
                ),
              if (flavor.flavor == Flavor.user) const Divider(height: 1),

              // Manage Payment Method
              if (flavor.flavor == Flavor.user)
                ActionRow(
                  label: 'Manage Payment Method',
                  onTap: () {
                    NavigateRoute.toManagePaymentMethod(context: context);
                  },
                ),
              if (flavor.flavor == Flavor.user) const Divider(height: 1),

              // Dark Mode Switch
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Text('Dark Mode'),
                    ),
                    Consumer<DarkModeProvider>(
                      builder: (context, darkMode, child) {
                        return Switch(
                          value: darkMode.isDarkMode,
                          onChanged: (value) {
                            darkMode.setDarkMode(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),

              // About Appliction
              ActionRow(
                label: 'About Application',
                onTap: () {
                  showAboutDialog(context: context);
                },
              ),
              const Divider(height: 1),

              // Logout
              ActionRow(
                label: 'Log Out',
                onTap: () {
                  Navigator.of(context).popAndPushNamed(RouteName.kLogin);
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  pickImage() async {
    try {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

      ImageSource? pickImageSource = await showDialog(
        context: context,
        builder: (context) {
          return const PickImageSource();
        },
      );

      if (pickImageSource != null) {
        await _picker.pickImage(source: pickImageSource).then((image) {
          if (image != null) {
            // TODO: Update profile Image
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
        ScaffoldMessenger.of(context).showMaterialBanner(
          errorBanner(context: context, msg: e.toString()),
        );
      }
    }
  }

  resetPassword({required String emailAddress}) async {
    try {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();

      // TODO: Reset Pasword

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email For Reset Password Sent'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showMaterialBanner(
        errorBanner(context: context, msg: e.toString()),
      );
    }
  }
}
