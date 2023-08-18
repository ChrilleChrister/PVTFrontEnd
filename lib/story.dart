//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'story_part.dart';
import 'package:json_annotation/json_annotation.dart';
//import 'story_location.dart';

part 'story.g.dart';


@JsonSerializable()
class Story{

  
  
  String name;
  int id;
  int startpart;
  int partid;

  Map<int, Object> parts = {};
 
  
   Story(String name, int id){
     this.name = name;
     this.id = id;
     this.startpart = 1;
     this.partid = 0;
    
   }
    void addPart(int id, Object part){
     
    parts[id] = part;
    
   }

   int assignPartId(){
     this.partid++;
     return partid;
   }

   int getStartPartId(){
     return startpart;
   }

   Object getPart(int x){
     return parts[x];
   }
   Map getParts(){
     return parts;
   }



   Object startStory(){

     return playPart(startpart);

   }

   Object playPart(id){
     return parts[id];

     }
  
   


   }

   


// @JsonSerializable()
// class StoryPart {

//   int id;
//   String type;
//   IconData icon;
//   List<int> triggers = List<int>();
//   int next;

//   StoryPart(int id, String type, IconData icon){
//     this.id = id;
//     this.type = type;
//     this.icon = icon;
//   }

  
//    String getType(){
//      return type;
//    }

//    int getId(){
//      return id;
//    }
//    void setNext(){
//     next = id+1;
//   }

//   int getNext(){
//     return next;
//   }
 

  


// }

// class StoryLocation extends StoryPart {
//   Marker marker;
//   int radius; //radiusen fran markern som den triggas ifran. EO
//   Color color;
//   bool triggered = false; //om den blivit uppspelad.  EO
//   bool triggerednow = false; //om du bifinner dig inom radiusen nu. EO
//   bool despawn = false; //om location ska tas bort om triggered. EO
//   bool visible = true; //om den ska synas pa kartan. EO


//   StoryLocation(int id, String type, IconData icon,int radius,Color color) : super(id, type, icon){
    
    
//     this.radius = radius;
//     this.color = color;
//   }

//   Marker getMarker(){

//     return marker;
//   }
//   void setMarker(Marker marker){
//     this.marker = marker;
//   }

//   int getRadius(){
//     return radius;
//   }


//   bool getDespawn(){
//     return despawn;
//   }



  

// }

// class StoryMessage extends StoryPart {
//   String message;

//   StoryMessage(int id, String type, IconData icon, String message) : super(id, type, icon){

//     this.message = message;
//   }

//   void displayMessage(){

//     print("message");
//   }

// }