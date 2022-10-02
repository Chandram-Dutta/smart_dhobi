import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/constants.dart';
import 'package:smart_dhobi/databases/cart_database.dart';

import '../../providers.dart';

class LaundryCart extends ConsumerWidget {
  const LaundryCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartDatabase cartDatabase = ref.watch(cartDatabaseProvider);
    return Column(
      children: [
        FutureBuilder(
            future: cartDatabase.getCartList(tshirtsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                    bottom: 160,
                  ),
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (snapshot.data.isEmpty) {
                          return SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Icon(Icons.cancel),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "${snapshot.data.elementAt(index).data["cart_name"]}",
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.add))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
      ],
    );
  }
}
