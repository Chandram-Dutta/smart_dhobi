import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

import '../constants.dart';

class BatchDatabase {
  Client client = appwriteClient;
  late Databases databases;

  BatchDatabase() {
    databases = Databases(client);
  }

  Future<List?> getBatchList() async {
    try {
      final response = await databases.listDocuments(
        collectionId: batchesCollectionId,
        databaseId: batchDatabaseId,
      );
      return response.documents;
    } catch (e) {
      return null;
    }
  }

  Future<Document> getBatch(String documentId) async {
    try {
      final response = await databases.getDocument(
        documentId: documentId,
        collectionId: batchesCollectionId,
        databaseId: batchDatabaseId,
      );
      return response;
    } catch (e) {
      log(e.toString());
      return Document(
          $id: "0",
          $collectionId: "0",
          $databaseId: "0",
          $createdAt: "0",
          $updatedAt: "0",
          $permissions: [],
          data: {});
    }
  }

  Future addPerson(String userId, String batchId, List users) async {
    try {
      databases.updateDocument(
        documentId: batchId,
        collectionId: batchesCollectionId,
        databaseId: batchDatabaseId,
        data: {
          "users": users,
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future createBatch(
    String userId,
  ) async {
    try {
      await databases.createDocument(
        documentId: "unique()",
        collectionId: batchesCollectionId,
        databaseId: batchDatabaseId,
        data: {
          "users": [],
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
