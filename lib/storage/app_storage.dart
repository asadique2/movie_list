import 'dart:developer';
import 'package:get_storage/get_storage.dart';

import '../model/model.dart';

class AppStorage {
  AppStorage._privateConstructor();

  static final _box = GetStorage();

  static Future setAllMovies(List<MovieModel> items) async {
    log('setAllMovies');
    await _box.write(AppStorageKeys.movies, items);
  }

  static Future<List> getAllMovies() async {
    log('getAllMovies');
    return await _box.read(AppStorageKeys.movies) ?? [];
  }
}

class AppStorageKeys {
  static const String movies = 'movies';
}
