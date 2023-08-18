// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    json['name'] as String,
    json['id'] as int,
  )
    ..startpart = json['startpart'] as int
    ..partid = json['partid'] as int
    ..parts = (json['parts'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e),
    );
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'startpart': instance.startpart,
      'partid': instance.partid,
      'parts': instance.parts?.map((k, e) => MapEntry(k.toString(), e)),
    };
