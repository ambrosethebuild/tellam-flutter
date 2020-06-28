import 'dart:async';
import 'AppDatabase.dart';

class AppDatabaseSingleton {
  static AppDatabase _database;

  Future<AppDatabase> get database async {
    if (_database != null) return _database;
    _database = await $FloorAppDatabase.databaseBuilder('tellam.db').build();
    return _database;
  }
}
