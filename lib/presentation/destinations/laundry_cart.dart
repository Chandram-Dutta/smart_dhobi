import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/databases/cart_database.dart';

import '../../providers.dart';

class LaundryCart extends ConsumerWidget {
  const LaundryCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartDatabase cartDatabase = ref.watch(cartDatabaseProvider);
    return FutureBuilder(
        future: cartDatabase.getCartList(),
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
                      return Dismissible(
                        background: Container(
                          alignment: Alignment.centerLeft,
                          color: Theme.of(context).colorScheme.error,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          alignment: Alignment.centerRight,
                          color: Theme.of(context).colorScheme.error,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ),
                        key: ValueKey<int>(index),
                        onDismissed: (DismissDirection direction) {
                          cartDatabase.removeCart(
                            snapshot.data.elementAt(index).data['\$id'],
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "${snapshot.data.elementAt(index).data["cart_name"]}",
                            ),
                          )),
                        ),
                      );
                    }
                  }),
            );
          } else {
            return const CupertinoActivityIndicator();
          }
        });
  }
}
