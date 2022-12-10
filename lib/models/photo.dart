import 'package:freezed_annotation/freezed_annotation.dart';

part "photo.freezed.dart";
part "photo.g.dart";

@freezed
class Photo with _$Photo {
  const Photo._();
  factory Photo({
    dynamic file,
    String? url,
    bool? isAddBtn,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
