import 'package:flutter/material.dart';
import 'package:magic_herb/auth/auth_services.dart';
import 'package:magic_herb/auth/user_model.dart';
import 'package:magic_herb/screens/navigation.dart';
import 'package:magic_herb/screens/onboardingScreen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_,AsyncSnapshot<User?>snapshot){
        if(snapshot.connectionState==ConnectionState.active){
          final User?user=snapshot.data;
          return user == null ? OnboardingScreen() : Navigation();
        } else {
          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
}
