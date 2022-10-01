import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_dhobi/databases/cart_database.dart';
import 'package:smart_dhobi/databases/schedule_database.dart';
import 'package:smart_dhobi/presentation/destinations/home.dart';

import 'auth/auth_service.dart';
import 'databases/batch_database.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final destinationProvider = StateProvider<int>((ref) {
  return 0;
});

final homeTypeProvider = StateProvider<HomeType>((ref) {
  return HomeType.schedule;
});

final scheduleDatabaseProvider = Provider<ScheduleDatabase>((ref) {
  return ScheduleDatabase();
});

final cartDatabaseProvider = Provider<CartDatabase>((ref) {
  return CartDatabase();
});

final cartListProvider = StateProvider<List<String>>((ref) {
  return [];
});

final batchDatabaseProvider = Provider<BatchDatabase>((ref) {
  return BatchDatabase();
});
