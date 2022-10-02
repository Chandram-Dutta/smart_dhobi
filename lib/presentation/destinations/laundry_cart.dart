import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/constants.dart';
import 'package:smart_dhobi/databases/cart_database.dart';
import 'package:smart_dhobi/presentation/widgets/loader_dialog.dart';

import '../../providers.dart';

class LaundryCart extends ConsumerWidget {
  LaundryCart({
    Key? key,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();

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
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("T-Shirt"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                tshirtsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        tshirtsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(shirtsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Shirts"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                shirtsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        shirtsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(ugarmentsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Undergarments"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                ugarmentsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        ugarmentsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(jeansCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Jeans"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                jeansCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        jeansCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(trackpantsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Track Pants"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                trackpantsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        trackpantsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(shortsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Shorts"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                shortsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        shortsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(bedsheetsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Bedsheets"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                bedsheetsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        bedsheetsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(towelsCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Towels"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                towelsCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        towelsCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        FutureBuilder(
            future: cartDatabase.getCartList(miscCollectionId),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                    right: 18.0,
                    top: 10,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text("Miscelleaneous"),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Adding item"),
                                        content: TextField(
                                          controller: textController,
                                          decoration: const InputDecoration(
                                            labelText: "Item Name",
                                          ),
                                        ),
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
                                              await cartDatabase
                                                  .addCart(
                                                miscCollectionId,
                                                textController.text,
                                              )
                                                  .then((value) {
                                                ref.refresh(
                                                    cartDatabaseProvider);
                                                textController.clear();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          Builder(builder: (context) {
                            if (snapshot.data.isEmpty) {
                              return const Center(
                                child: Text("No items"),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    secondaryBackground: Container(
                                      alignment: Alignment.centerRight,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    background: Container(
                                      alignment: Alignment.centerLeft,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      child: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                      ),
                                    ),
                                    onDismissed: (direction) async {
                                      await cartDatabase.removeCart(
                                        snapshot.data
                                            .elementAt(index)
                                            .data["\$id"],
                                        miscCollectionId,
                                      );
                                    },
                                    child: SizedBox(
                                      height: 25,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "${snapshot.data.elementAt(index).data["item"]}",
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CupertinoActivityIndicator();
              }
            }),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
