import 'package:realm/realm.dart';

part 'realm_models.realm.dart';

@RealmModel()
class _RememberMePreference {
  @PrimaryKey()
  late String id;
  late bool shouldRemember;
  late String? userEmail;
}
