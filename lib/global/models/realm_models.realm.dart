// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_models.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class RememberMePreference extends _RememberMePreference
    with RealmEntity, RealmObjectBase, RealmObject {
  RememberMePreference(String id, bool shouldRemember, {String? userEmail}) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'shouldRemember', shouldRemember);
    RealmObjectBase.set(this, 'userEmail', userEmail);
  }

  RememberMePreference._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  bool get shouldRemember =>
      RealmObjectBase.get<bool>(this, 'shouldRemember') as bool;
  @override
  set shouldRemember(bool value) =>
      RealmObjectBase.set(this, 'shouldRemember', value);

  @override
  String? get userEmail =>
      RealmObjectBase.get<String>(this, 'userEmail') as String?;
  @override
  set userEmail(String? value) => RealmObjectBase.set(this, 'userEmail', value);

  @override
  Stream<RealmObjectChanges<RememberMePreference>> get changes =>
      RealmObjectBase.getChanges<RememberMePreference>(this);

  @override
  Stream<RealmObjectChanges<RememberMePreference>> changesFor([
    List<String>? keyPaths,
  ]) => RealmObjectBase.getChangesFor<RememberMePreference>(this, keyPaths);

  @override
  RememberMePreference freeze() =>
      RealmObjectBase.freezeObject<RememberMePreference>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'shouldRemember': shouldRemember.toEJson(),
      'userEmail': userEmail.toEJson(),
    };
  }

  static EJsonValue _toEJson(RememberMePreference value) => value.toEJson();
  static RememberMePreference _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {'id': EJsonValue id, 'shouldRemember': EJsonValue shouldRemember} =>
        RememberMePreference(
          fromEJson(id),
          fromEJson(shouldRemember),
          userEmail: fromEJson(ejson['userEmail']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RememberMePreference._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
      ObjectType.realmObject,
      RememberMePreference,
      'RememberMePreference',
      [
        SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
        SchemaProperty('shouldRemember', RealmPropertyType.bool),
        SchemaProperty('userEmail', RealmPropertyType.string, optional: true),
      ],
    );
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
