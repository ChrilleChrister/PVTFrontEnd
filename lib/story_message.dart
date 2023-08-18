
import 'package:json_annotation/json_annotation.dart';
//import 'package:flutter/material.dart';
//import 'story.dart';

part 'story_message.g.dart';

@JsonSerializable()
class StoryMessage {
  int id;
  String name;
  String type;
  String message;
  int next;
  bool stayinarea = false;

  StoryMessage(int id, String type, /*IconData icon,*/ /*String message*/){

    this.id = id;
    this.type = type;
    name = id.toString();
  }

  // void displayMessage(){

  //   print("message");
  // }

}
