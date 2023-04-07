import 'package:get/get.dart';

class AppTranslation extends Translations {
  Map<String, Map<String, String>> get keys => {
        'en': {
          'signin': 'Sign In',
          // Setting page
          'settings.title': 'Settings',
          'settings.pushTitle': 'Push Notification',
          'settings.pushEnable': 'Enable',
          'settings.label': 'Labels on Map',
          'settings.language': 'Language',
          'settings.version': 'Version',
        },
        'fr': {
          'signin': "S'identifier",
          // Setting page
          'settings.title': "Paramètres",
          'settings.pushTitle': 'Notification push',
          'settings.pushEnable': 'Activer',
          'settings.label': "Étiquettes sur la carte",
          'settings.language': 'Langue',
          'settings.version': 'Version',
        }
      };
}
