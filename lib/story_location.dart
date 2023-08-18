
import 'package:json_annotation/json_annotation.dart';
part 'story_location.g.dart';

@JsonSerializable()
class StoryLocation {
  //Marker marker;
  //LatLng marker;
  int id;
  String name;
  int next;
  String type;
  double markerlat;
  double markerlng;
  int codepoint = 58727;
  String fontfamily = 'MaterialIcons';
  int radius; //radiusen fran markern som den triggas ifran. EO
  //Color color;
  bool triggered = false; //om den blivit uppspelad.  EO
  bool triggerednow = false; //om du bifinner dig inom radiusen nu. EO
  bool despawn = false; //om location ska tas bort om triggered. EO
  bool visible = true; //om den ska synas pa kartan. EO


  StoryLocation(int id, String type, /*IconData icon,*/ int radius,/*Color color*/){
    
    
    this.radius = radius;
    this.id = id;
    this.type = type;
    name = id.toString();

    //this.color = color;
  }
//factory StoryLocation.fromJson(Map<String, dynamic> json) => _$StoryLocationFromJson(json);

  void setMarker(double markerlat, markerlng){
    this.markerlat = markerlat;
    this.markerlng = markerlng;
  }

  setId(int id){
    this.id = id;
    name = id.toString();
  }

  
  

}