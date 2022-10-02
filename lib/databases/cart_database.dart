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

  Future removeCart(String documentId) async {
    try {
      await databases.deleteDocument(
        documentId: documentId,
        collectionId: cartCollectionId,
        databaseId: laundryDatabaseId,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future createCart(
    String cartName,
    String userId,
  ) async {
    try {
      await databases.createDocument(
        documentId: "unique()",
        permissions: [
          Permission.update(
            Role.user(userId),
          ),
          Permission.delete(
            Role.user(userId),
          ),
          Permission.read(
            Role.user(userId),
          ),
          Permission.write(
            Role.user(userId),
          ),
        ],
        collectionId: cartCollectionId,
        databaseId: laundryDatabaseId,
        data: {
          "cart_name": cartName,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
