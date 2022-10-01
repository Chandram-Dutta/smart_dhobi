import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.background,
                  offset: const Offset(-10, -10),
                  blurRadius: 50,
                  spreadRadius: 2,
                ),
                const BoxShadow(
                  color: Colors.black,
                  offset: Offset(20, 20),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoActivityIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
