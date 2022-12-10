import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value.toDate();

  @override
  Timestamp toJson(DateTime value) => Timestamp.fromDate(value);
}

class TimestampNullableConverter
    implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampNullableConverter();

  @override
  DateTime? fromJson(Timestamp? value) => value?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class ServerTimestampConverter implements JsonConverter<DateTime, Object?> {
  const ServerTimestampConverter();

  @override
  DateTime fromJson(Object? timestamp) {
    if (timestamp == null) {
      return DateTime.now();
    }

    return (timestamp as Timestamp).toDate();
  }

  @override
  Object toJson(DateTime _) => FieldValue.serverTimestamp();
}

class DocumentRefConverter
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentRefConverter();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}
