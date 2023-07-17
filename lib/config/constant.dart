import 'package:flutter/material.dart';

class ApiURL {
  static String app_base_url = "https://client.traxy.mobi";
  static String LOGIN_URL = '${ApiURL.app_base_url}/api/login';
  static String LOGOUT_URL = '${ApiURL.app_base_url}/api/logout';
  static String GROUPS_URL = '${ApiURL.app_base_url}/api/trackers/groups';
  static String TRACKERS_URL = '${ApiURL.app_base_url}/api/trackers';
}
