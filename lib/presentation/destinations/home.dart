// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:smart_dhobi/auth/auth_service.dart';
import 'package:smart_dhobi/databases/cart_database.dart';
import 'package:smart_dhobi/databases/schedule_database.dart';
import 'package:smart_dhobi/presentation/widgets/loader_dialog.dart';
import 'package:smart_dhobi/presentation/widgets/timestamp.dart';

import '../../providers.dart';

enum HomeType { schedule, current }

Map<HomeType, Widget> homeType = <HomeType, Widget>{
  HomeType.schedule: const Text("Schedule"),
  HomeType.current: const Text("Current"),
};

class Home extends ConsumerWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(
          height: 20,
        ),
        MaterialSegmentedControl<HomeType>(
          selectionIndex: ref.watch(homeTypeProvider),
          unselectedColor: Theme.of(context).colorScheme.onPrimary,
          borderRadius: 20.0,
          children: homeType,
          onSegmentChosen: (value) {
            ref.read(homeTypeProvider.state).state = value;
          },
        ),
        Builder(
          builder: (context) {
            switch (ref.watch(homeTypeProvider)) {
              case HomeType.schedule:
                return ScheduleDestination();
              case HomeType.current:
                return const CurrentDestination();
              default:
                return const Text("Error");
            }
          },
        )
      ],
    );
  }
}

class CurrentDestination extends ConsumerWidget {
  const CurrentDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AuthService authService = ref.watch(authServiceProvider);
    return FutureBuilder(
        future: authService.account.then((value) => value!.$id),
        builder: (context, snap) {
          return FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                    bottom: 120,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data
                          .elementAt(index)
                          .data["users"]
                          .contains(snap.data.toString())) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Batch ID: ${snapshot.data.elementAt(index).data["\$id"]}",
                                ),
                                const Divider(),
                                const Text(
                                  "Progress",
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: snapshot.data
                                          .elementAt(index)
                                          .data["index"],
                                      onChanged: (value) {},
                                    ),
                                    const Text("Received"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: snapshot.data
                                          .elementAt(index)
                                          .data["index"],
                                      onChanged: (value) {},
                                    ),
                                    const Text("Washing..."),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: snapshot.data
                                          .elementAt(index)
                                          .data["index"],
                                      onChanged: (value) {},
                                    ),
                                    const Text("Folding..."),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: snapshot.data
                                          .elementAt(index)
                                          .data["index"],
                                      onChanged: (value) {},
                                    ),
                                    const Text("Ready!"),
                                  ],
                                ),
                                const Divider(),
                                const Text("Notifications"),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                  itemCount: snapshot.data
                                      .elementAt(index)
                                      .data["notifications"]
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index1) {
                                    if (snapshot.data
                                        .elementAt(index)
                                        .data["notifications"]
                                        .isEmpty) {
                                      return const Text("No Notifications");
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data
                                                .elementAt(index)
                                                .data["notifications"][index1],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
            future: ref.watch(batchDatabaseProvider).getBatchList(),
          );
        });
  }
}

class ScheduleDestination extends ConsumerWidget {
  ScheduleDestination({
    Key? key,
  }) : super(key: key);

  final TextEditingController noOfClothes = TextEditingController();
  final TextEditingController noOfWashes = TextEditingController();
  final TextEditingController maxClothesPerWash = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartDatabase cartDatabase = ref.watch(cartDatabaseProvider);
    ScheduleDatabase scheduleDatabase = ref.watch(scheduleDatabaseProvider);
    AuthService authService = ref.watch(authServiceProvider);
    return FutureBuilder(
      future: scheduleDatabase.getScheduleList(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_rounded,
                      color: Theme.of(context).colorScheme.error,
                      size: 200,
                    ),
                    const Text("No Schedule Found"),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    showLoaderDialog(context);
                                    await scheduleDatabase.createSchdule(
                                      int.parse(noOfClothes.text),
                                      int.parse(noOfWashes.text),
                                      DateTime.now()
                                          .add(const Duration(days: 1)),
                                      int.parse(maxClothesPerWash.text),
                                      await authService.account
                                          .then((value) => value!.$id),
                                    );
                                    ref.refresh(scheduleDatabaseProvider);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Create"),
                                ),
                              ],
                              title: const Text("Create Schedule"),
                              content: Column(
                                children: [
                                  TextField(
                                    controller: noOfClothes,
                                    decoration: const InputDecoration(
                                      labelText: "Number of clothes you own",
                                    ),
                                  ),
                                  TextField(
                                    controller: noOfWashes,
                                    decoration: const InputDecoration(
                                      labelText: "Number of Washes",
                                    ),
                                  ),
                                  TextField(
                                    controller: maxClothesPerWash,
                                    decoration: const InputDecoration(
                                      labelText: "Max Clothes per Wash",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Start Date: Tomorrow",
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: const Text("Create Schedule"),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                top: 10,
                bottom: 120,
              ),
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  if (index == 0) {
                    return const Divider();
                  } else {
                    return const SizedBox();
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () async {
                        showLoaderDialog(context);
                        ref.read(cartListProvider.state).state = await ref
                            .watch(scheduleDatabaseProvider)
                            .getCartList(
                                snapshot.data.elementAt(index).data['\$id']);
                        int max = snapshot.data.elementAt(index).data['max'];
                        Navigator.pop(context);
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                                builder: (context, StateSetter setState) {
                              return SizedBox(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const <Widget>[],
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              const Text("Next Laundry Date"),
                              Text(
                                readTimestamp(
                                  snapshot.data
                                      .elementAt(index)
                                      .data['laundry_date'],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        showLoaderDialog(context);
                        ref.read(cartListProvider.state).state = await ref
                            .watch(scheduleDatabaseProvider)
                            .getCartList(
                              snapshot.data.elementAt(index).data['\$id'],
                            );
                        int max = snapshot.data.elementAt(index).data['max'];
                        Navigator.pop(context);
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(
                              builder: (context, StateSetter setState) {
                                return SizedBox(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: const <Widget>[],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Dismissible(
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
                          scheduleDatabase.removeSchedule(
                            snapshot.data.elementAt(index).data['\$id'],
                          );
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(
                                readTimestamp(snapshot.data
                                    .elementAt(index)
                                    .data['laundry_date']),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          }
        } else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
