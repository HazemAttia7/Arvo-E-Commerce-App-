import 'package:e_commerce_app/Create%20Account/views/create_account_view.dart';
import 'package:e_commerce_app/Home%20Page/views/home_view.dart';
import 'package:e_commerce_app/Landing%20Page/views/landing_view.dart';
import 'package:e_commerce_app/Login/views/login_view.dart';
import 'package:e_commerce_app/Main%20Screen/views/main_view.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/models/user_model.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: provider.Provider<RealmPreferenceService>(
        create: (_) => RealmPreferenceService(),
        dispose: (_, service) => service.dispose(),
        child: const ECommerceApp(),
      ),
    ),
  );
}

class ECommerceApp extends StatefulWidget {
  const ECommerceApp({super.key});

  @override
  State<ECommerceApp> createState() => _ECommerceAppState();
}

class _ECommerceAppState extends State<ECommerceApp> {
  late Future<UserModel?> _initialUserLoadFuture;
  @override
  void initState() {
    super.initState();
    _initialUserLoadFuture = _loadInitialUserData();
  }

  Future<UserModel?> _loadInitialUserData() async {
    final realmPreferenceService = provider.Provider.of<RealmPreferenceService>(
      context,
      listen: false,
    );
    final bool shouldRememberMe =
        realmPreferenceService.getRememberMePreference();
    final String? rememberedEmail = realmPreferenceService.getEmail();

    if (shouldRememberMe) {
      UserModel? userProfile = await AuthService.getUserProfileByEmail(
        context,
        email: rememberedEmail,
      );
      if (userProfile != null) {
        currentUser = userProfile;
        return userProfile;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LandingView.route: (context) => const LandingView(),
        LoginView.route: (context) => const LoginView(),
        CreateAccountView.route: (context) => const CreateAccountView(),
        HomeView.route: (context) => const HomeView(),
        MainView.route: (context) => const MainView(),
      },
      theme: ThemeData(fontFamily: "Work Sans"),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<UserModel?>(
        future: _initialUserLoadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(color: Colors.black),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Error loading user data.',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        currentUser = null;
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(LoginView.route);
                      },
                      child: const Text('Go to Login'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            if (currentUser != null) {
              return const MainView();
            } else {
              return const LandingView();
            }
          }
        },
      ),
    );
  }
}
