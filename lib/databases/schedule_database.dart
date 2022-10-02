import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:smart_dhobi/constants.dart';

class ScheduleDatabase {
  Client client = appwriteClient;
  late Databases databases;

  ScheduleDatabase() {
    databases = Databases(client);
  }

  Future<List?> getScheduleList() async {
    try {
      final response = await databases.listDocuments(
        collectionId: scheduleCollectionId,
        databaseId: laundryDatabaseId,
      );
      return response.documents;
    } catch (e) {
      return null;
    }
  }

  Future removeSchedule(String documentId) async {
    try {
      await databases.deleteDocument(
        documentId: documentId,
        collectionId: scheduleCollectionId,
        databaseId: laundryDatabaseId,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<String>> getCartList(String documentId) async {
    try {
      final response = await databases.getDocument(
        documentId: documentId,
        collectionId: scheduleCollectionId,
        databaseId: laundryDatabaseId,
      );
      return List<String>.from(response.data["cart_list"]);
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future syncClothList(List<String> clothList, String documentId) async {
    try {
      await databases.updateDocument(
        documentId: documentId,
        collectionId: scheduleCollectionId,
        databaseId: laundryDatabaseId,
        data: {"cart_list": clothList},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future createSchdule(
    int noOfTotalClothes,
    int noOfWashes,
    DateTime dateTime,
    int maxClothes,
    String userId,
  ) async {
    int i = (noOfTotalClothes / maxClothes).floor();
    int j = noOfTotalClothes % maxClothes;

    print(i);
    print(j);

    for (int i = 0; i < noOfWashes; i++) {
      if (i != 0) {
        try {
          await databases.createDocument(
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
            documentId: "unique()",
            collectionId: scheduleCollectionId,
            databaseId: laundryDatabaseId,
            data: {
              "laundry_date": dateTime.toIso8601String(),
              "max": i,
              "cart_list": []
            },
          );
        } catch (e) {
          log(
            e.toString(),
          );
        }
        dateTime = dateTime.add(
          const Duration(days: 7),
        );
      } else {
        try {
          await databases.createDocument(
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
            documentId: "unique()",
            collectionId: scheduleCollectionId,
            databaseId: laundryDatabaseId,
            data: {
              "laundry_date": dateTime.toIso8601String(),
              "max": maxClothes,
              "cart_list": []
            },
          );
        } catch (e) {
          log(e.toString());
        }
        dateTime = dateTime.add(
          const Duration(days: 7),
        );
      }
    }
  }
}
