// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/auth/auth_service.dart';

import '../../providers.dart';
import '../destinations/account.dart';
import '../destinations/home.dart';
import '../destinations/laundry_cart.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({Key? key}) : super(key: key);

  final TextEditingController clothesController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.watch(authServiceProvider);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.background,
                          offset: const Offset(-10, -10),
                          blurRadius: 50,
                          spreadRadius: 2,
                        ),
                        const BoxShadow(
                          color: Colors.black,
                          offset: Offset(10, 10),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Smart Dhobi",
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  Builder(builder: (context) {
                    switch (ref.watch(destinationProvider)) {
                      case 0:
                        return const Home();
                      case 1:
                        return const Text("Notifications");
                      case 2:
                        return const Account();
                      case 3:
                        return LaundryCart();
                      default:
                        return const Text("Error");
                    }
                  })
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -2,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, -10),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ref.watch(destinationProvider) == 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.background,
                            offset: const Offset(-10, -10),
                            blurRadius: 50,
                            spreadRadius: 2,
                          ),
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(10, 10),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            ref.read(destinationProvider.state).state = 0;
                          },
                          tooltip: "Home",
                          icon: const Icon(Icons.home),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ref.watch(destinationProvider) == 3
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.background,
                            offset: const Offset(-10, -10),
                            blurRadius: 50,
                            spreadRadius: 2,
                          ),
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(10, 10),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            ref.read(destinationProvider.state).state = 3;
                          },
                          tooltip: "Laundry Cart",
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ref.watch(destinationProvider) == 2
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.background,
                            offset: const Offset(-10, -10),
                            blurRadius: 50,
                            spreadRadius: 2,
                          ),
                          const BoxShadow(
                            color: Colors.black,
                            offset: Offset(10, 10),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            ref.read(destinationProvider.state).state = 2;
                          },
                          tooltip: "Account",
                          icon: const Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
