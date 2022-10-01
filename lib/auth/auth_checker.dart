import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/auth/auth_service.dart';
import 'package:smart_dhobi/presentation/screen/loading_screen.dart';

import '../presentation/screen/home_screen.dart';
import '../presentation/screen/signin_screen.dart';
import '../providers.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.watch(authServiceProvider);
    Future<Account> account = authService.account;
    return FutureBuilder(
      future: account,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SignInScreen();
        } else if (snapshot.hasData) {
          return  HomeScreen();
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
