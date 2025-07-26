import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Landing%20Page/views/landing_view.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

// PROFILE PAGE NOT IMPLEMENTED YET
class _ProfileViewState extends State<ProfileView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final realmPreferenceService = Provider.of<RealmPreferenceService>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CustomBackButton(),
              Text(
                "GO BACK TO MAIN SCREEN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child:
                    isLoading
                        ? const CustomLoadingIndicator()
                        : CustomButton(
                          text: "Logout",
                          onTap: () async {
                            bool loggedOut = await AuthService.performLogout(
                              context,
                              realmPreferenceService: realmPreferenceService,
                              triggerLoading: () {
                                setState(() {
                                  isLoading = true;
                                });
                              },
                            );
                            setState(() {
                              isLoading = false;
                            });
                            if (loggedOut) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                LandingView.route,
                                (route) => false,
                              );
                            }
                          },
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
