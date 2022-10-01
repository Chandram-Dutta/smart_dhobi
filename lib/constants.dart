import 'package:appwrite/appwrite.dart';

const String projectId = "6336ddd08271d9d0d5c9";
const String apiEndpoint = "http://localhost/v1";
const String laundryDatabaseId = "63371198ecf2cf7a6fe1";
const String scheduleCollectionId = "633711aebe125be16e9d";
const String cartCollectionId = "63376a134ecee9a91f54";
const String batchDatabaseId = "633860691776623a28a3";
const String batchesCollectionId = "6338609302e5220f6e38";


Client appwriteClient = Client()
    .setEndpoint(apiEndpoint)
    .setProject(projectId)
    .setSelfSigned(status: true);
