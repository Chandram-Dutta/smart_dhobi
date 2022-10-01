// ignore_for_file: use_build_context_synchronously

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:smart_dhobi/constants.dart';

class AuthService {
  late final Client client;
  late final Account _account;
  late final Future<models.Account> _userAccount;

  get account => _userAccount;

  AuthService() {
    client = Client()
        .setEndpoint(apiEndpoint)
        .setProject(projectId)
        .setSelfSigned(status: true);
    _account = Account(client);
    _userAccount = _account.get();
  }

  Future<String> createAccout(
      String email, String password, String name) async {
    try {
      await _account.create(
        userId: 'unique()',
        email: email,
        name: name,
        password: password,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createSession(String email, String password) async {
    try {
      await _account.createEmailSession(
        email: email,
        password: password,
      );
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteSession() async {
    try {
      await _account.deleteSessions();
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}
