import 'package:appwrite/appwrite.dart';

const String projectId = "6336ddd08271d9d0d5c9";
const String apiEndpoint = "http://localhost/v1";
const String laundryDatabaseId = "63371198ecf2cf7a6fe1";
const String scheduleCollectionId = "633711aebe125be16e9d";
const String cartCollectionId = "63376a134ecee9a91f54";
const String batchDatabaseId = "633860691776623a28a3";
const String batchesCollectionId = "6338609302e5220f6e38";
const String cartDatabaseId = "6338d2e68f6cddf6b4ff";
const String miscCollectionId = "6338d3af1ceb1483b4e7";
const String towelsCollectionId = "6338d3f86409aba93621";
const String bedsheetsCollectionId = "6338d404d54794a408b5";
const String shortsCollectionId = "6338d417a532c85c324c";
const String trackpantsCollectionId = "6338d4272f7845f0368e";
const String jeansCollectionId = "6338d4343a1cd0b5d40b";
const String ugarmentsCollectionId = "6338d446bfc3adf920a1";
const String shirtsCollectionId = "6338d455ead08822112b";
const String tshirtsCollectionId = "6338d466a1969d99cb65";

Client appwriteClient = Client()
    .setEndpoint(apiEndpoint)
    .setProject(projectId)
    .setSelfSigned(status: true);
