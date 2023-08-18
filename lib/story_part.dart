// import 'package:flutter/material.dart';
// import 'package:json_annotation/json_annotation.dart';
// //import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'story_location.dart';
// import 'story_message.dart';

// part 'storypart.g.dart';



// @JsonSerializable()
// class StoryPart extends Object with _$BaseSerializerMixin {

//   int id;
//   String type;
//   //IconData icon;
//   //List<int> triggers = List<int>();
//   int next;
//   //codePoint {this.fontFamily, this.fontPackage, this.matchTextDirection};

//   StoryPart(int id, String type/*, IconData icon*/){
//     this.id = id;
//     this.type = type;
//     //this.icon = icon;
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
//    factory StoryPart.fromJson(Map<String, dynamic> json) => _$StoryPartFromJson(json);
 
 
  


// }
// //@JsonSerializable()

// // class StoryLocation extends StoryPart with _$StoryLocationSerializerMixin {
// //   //Marker marker;
// //   //LatLng marker;
// //   double markerlat;
// //   double markerlng;
// //   int radius; //radiusen fran markern som den triggas ifran. EO
// //   //Color color;
// //   bool triggered = false; //om den blivit uppspelad.  EO
// //   bool triggerednow = false; //om du bifinner dig inom radiusen nu. EO
// //   bool despawn = false; //om location ska tas bort om triggered. EO
// //   bool visible = true; //om den ska synas pa kartan. EO
// //   factory StoryLocation.fromJson(Map<String, dynamic> json) => _$StoryLocationFromJson(json);


// //   StoryLocation(int id, String type, /*IconData icon,*/ int radius,/*Color color*/) : super(id, type/*, icon*/){
    
    
// //     this.radius = radius;
// //     //this.color = color;
// //   }

// //   // LatLng getMarker(){

// //   //   return marker;
// //   // }
// //   // void setMarker(LatLng marker){
// //   //   this.marker = marker;
// //   // }

// //   void setMarker(double markerlat, markerlng){
// //     this.markerlat = markerlat;
// //     this.markerlng = markerlng;
// //   }

// //   int getRadius(){
// //     return radius;
// //   }


// //   bool getDespawn(){
// //     return despawn;
// //   }



  

// // }
// // //@JsonSerializable()
// // class StoryMessage extends StoryPart {
// //   String message;

// //   StoryMessage(int id, String type, /*IconData icon,*/ String message) : super(id, type/*, icon*/){

// //     this.message = message;
// //   }

// //   void displayMessage(){

// //     print("message");
// //   }

// // }