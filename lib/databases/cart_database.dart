import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:smart_dhobi/constants.dart';

class CartDatabase {
  Client client = appwriteClient;
  late Databases databases;

  CartDatabase() {
    databases = Databases(client);
  }

  Future<List?> getCartList(String collectionID) async {
    try {
      final response = await databases.listDocuments(
        collectionId: collectionID,
        databaseId: cartDatabaseId,
      );
      return response.documents;
    } catch (e) {
      return null;
    }
  }

  Future addCart(String collectionID, String item) async {
    try {
      await databases.createDocument(
        documentId: "unique()",
        collectionId: collectionID,
        databaseId: cartDatabaseId,
        data: {
          "item": item,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future removeCart(String documentId, String collectionId) async {
    try {
      await databases.deleteDocument(
        documentId: documentId,
        collectionId: collectionId,
        databaseId: cartDatabaseId,
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
