// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_dhobi/auth/auth_service.dart';
import 'package:smart_dhobi/presentation/screen/signin_screen.dart';
import 'package:smart_dhobi/presentation/widgets/loader_dialog.dart';

import '../../providers.dart';

class Account extends ConsumerWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.watch(authServiceProvider);
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: FutureBuilder(
              future: authService.account.then((value) => value!.$id),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: QrImage(
                            backgroundColor: Colors.white,
                            data: snapshot.data.toString(),
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
                        ),
                        SelectableText(
                          snapshot.data.toString(),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.error,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Theme.of(context).colorScheme.onError,
                ),
              ),
              onPressed: () async {
                showLoaderDialog(context);
                await authService.deleteSession();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                "Logout",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
