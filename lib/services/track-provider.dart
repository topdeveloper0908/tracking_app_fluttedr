import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackProvider extends ChangeNotifier {
  String _groups = "";
  String _tracks = "";
  List<int> counts = [];
  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setGroups(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString("groups", val);
    notifyListeners();
  }

  Future<List<dynamic>> getGroups() async {
    await init();
    var value = _sharedPreferences.getString("groups") ?? '';
    return Future<List<dynamic>>.value(jsonDecode(value));
  }

  Future<void> setTracks(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString("tracks", val);
    notifyListeners();
  }

  Future<List<dynamic>> getTracks() async {
    await init();
    var value = _sharedPreferences.getString("tracks") ?? '';
    return Future<List<dynamic>>.value(jsonDecode(value));
  }

  List<int> getCounts(groups, tracks) {
    counts = [];
    var main = 0;
    for (var i = 0; i < groups.length; i++) {
      var tmp = 0;
      for (var j = 0; j < tracks.length; j++) {
        if (groups[i]['id'] == tracks[j]['groupId']) {
          tmp++;
        }
        if (tracks[j]['groupId'] == null) main++;
      }
      counts.add(tmp);
    }
    counts.add(main);
    return counts;
  }
}
