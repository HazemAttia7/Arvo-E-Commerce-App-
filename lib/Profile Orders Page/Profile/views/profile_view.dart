import 'package:e_commerce_app/Home%20Page/widgets/clickable_modern_underlined_text.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Landing%20Page/views/landing_view.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/services/orders_service.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Orders/widgets/orders_history_card.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/helper/email_notifier.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/helper/name_notifier.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/confirm_pass_dialog_body.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Orders/models/order_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isLoading = false;
  late Future<List<OrderModel>> _initGetAllOrders;
  @override
  void initState() {
    _initGetAllOrders = OrdersService.getOrders(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NameNotifier.updateName(context);
    });
  }

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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                CustomBackButton(),
                Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ValueListenableBuilder<String>(
            valueListenable: NameNotifier.userName,
            builder: (BuildContext context, String userName, Widget? child) {
              return CustomText(
                text: userName,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              );
            },
          ),
          ValueListenableBuilder<String>(
            valueListenable: EmailNotifier.userEmail,
            builder: (BuildContext context, String userEmail, Widget? child) {
              return Text(
                userEmail,
                style: const TextStyle(fontSize: 16, color: Color(0xff757575)),
              );
            },
          ),
          const SizedBox(height: 25),
          CustomButton(
            text: "Edit",
            textColor: Colors.black,
            borderRadius: 0,
            backColor: const Color(0xffE9E9E9),
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true, // Allow dismissing by tapping outside
                builder: (BuildContext context) {
                  return const ConfirmPassDialogBody();
                },
              );
            },
          ),
          const SizedBox(height: 15),
          isLoading
              ? const CustomLoadingIndicator()
              : CustomButton(
                text: "Log Out",
                borderRadius: 0,
                backColor: const Color(0xff3C3C3C),
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
          const SizedBox(height: 30),
          ClickableModernUnderlinedText(
            text: "Orders History",
            onTap: () {},
            underlineWidth: 200,
            underlineThickness: 4,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          Expanded(
            child: FutureBuilder(
              future: _initGetAllOrders,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
                if (snapshot.hasData) {
                  List<OrderModel> ordersList = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: ordersList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          OrdersHistoryCard(order: ordersList[index]),
                          if (index != ordersList.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(color: Colors.black),
                            ),
                        ],
                      );
                    },
                  );
                } else {
                  return const SizedBox(
                    child: Text("There is no orders placed yet ."),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
