// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryMessage _$StoryMessageFromJson(Map<String, dynamic> json) {
  return StoryMessage(
    json['id'] as int,
    json['type'] as String,
  )
    ..name = json['name'] as String
    ..message = json['message'] as String
    ..next = json['next'] as int
    ..stayinarea = json['stayinarea'] as bool;
}

Map<String, dynamic> _$StoryMessageToJson(StoryMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'message': instance.message,
      'next': instance.next,
      'stayinarea': instance.stayinarea,
    };
