import 'package:realm/realm.dart';
import 'package:e_commerce_app/global/models/realm_models.dart';

class RealmPreferenceService {
  late Realm _realm;

  RealmPreferenceService() {
    var config = Configuration.local([
      RememberMePreference.schema,
    ], schemaVersion: 1);
    _realm = Realm(config);
  }

  bool getRememberMePreference() {
    final preference = _realm.all<RememberMePreference>().firstOrNull;
    return preference?.shouldRemember ?? false;
  }

  String? getEmail() {
    final preference = _realm.all<RememberMePreference>().firstOrNull;
    return preference?.userEmail;
  }

  Future<void> setRememberMePreference({ required bool remember, String? email}) async {
    return _realm.writeAsync(() {
      _realm.add(
        RememberMePreference(
          'user_remember_me_flag',
          remember,
          userEmail: email,
        ),
        update: true,
      );
    });
  }

  Future<void> clearRememberMePreference() async {
    final preference = _realm.all<RememberMePreference>().firstOrNull;
    if (preference != null) {
      return _realm.writeAsync(() {
        _realm.delete(preference);
      });
    }
  }

  void dispose() {
    _realm.close();
  }
}
