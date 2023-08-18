// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryLocation _$StoryLocationFromJson(Map<String, dynamic> json) {
  return StoryLocation(
    json['id'] as int,
    json['type'] as String,
    json['radius'] as int,
  )
    ..name = json['name'] as String
    ..next = json['next'] as int
    ..markerlat = (json['markerlat'] as num)?.toDouble()
    ..markerlng = (json['markerlng'] as num)?.toDouble()
    ..codepoint = json['codepoint'] as int
    ..fontfamily = json['fontfamily'] as String
    ..triggered = json['triggered'] as bool
    ..triggerednow = json['triggerednow'] as bool
    ..despawn = json['despawn'] as bool
    ..visible = json['visible'] as bool;
}

Map<String, dynamic> _$StoryLocationToJson(StoryLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'next': instance.next,
      'type': instance.type,
      'markerlat': instance.markerlat,
      'markerlng': instance.markerlng,
      'codepoint': instance.codepoint,
      'fontfamily': instance.fontfamily,
      'radius': instance.radius,
      'triggered': instance.triggered,
      'triggerednow': instance.triggerednow,
      'despawn': instance.despawn,
      'visible': instance.visible,
    };
