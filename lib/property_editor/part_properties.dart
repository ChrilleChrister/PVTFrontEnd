import 'package:flutter/material.dart';
//import 'package:flutter_maps/story.dart';
//import '../story_part.dart';
import '../story_location.dart';
import '../story_message.dart';




//class AdventureLocationProperties extends StatelessWidget {
class AdventureLocationProperties extends StatefulWidget {
  AdventureLocationProperties(this.sl);
  final StoryLocation sl;
  

  @override
  _AdventureLocationPropertiesState createState() => _AdventureLocationPropertiesState(sl);
}

class _AdventureLocationPropertiesState extends State<AdventureLocationProperties> {

  StoryLocation sl;
  final radiusController = TextEditingController(); //lyssnar pa ett texfield behovs en for varje field. EO
  final triggerController = TextEditingController();

  _AdventureLocationPropertiesState(StoryLocation sl){
    this.sl = sl;
  }
  
  
  //sag till om ni vill ha mer kommentarer i denna kod. kandes ganska 
  //straight forward men kanske lite blind for nagon komplexitet EO

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Properties for " + sl.type + " " + sl.id.toString() ),
      ),
      body: Center(
        
        
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
       
        children: <Widget>[
          Row(

         children: <Widget>[
            
           Text('Radius: '),

        Container(              
  width: 100.0,
  child: TextField(  
    controller: radiusController,
    

    style: TextStyle(
      fontSize: 15.0,
      height: 2.0,
      color: Colors.black                  
    ),
    decoration: InputDecoration(
      hintText: sl.radius.toString(),
      labelText: 'radius',
      
          ),
  )
  
),
RaisedButton(
          onPressed: () {
            sl.radius =  int.parse(radiusController.text); //satter radiusen till det i fielden
          },
          child: Text('SET'),
          
        ),

          
       ],
         ),
  Row(

         children: <Widget>[
            
           Text('Visible? '),

        Checkbox(
  
  value: sl.visible,
   onChanged: (bool newvalue) { //boxen satter bool i StoryLocation EO
     setState(() {
                     sl.visible = newvalue;
                });
    
    },
),

          
       ],
         ),
  Row(

         children: <Widget>[
            
           Text('Despawn on triggered? '),

        Checkbox(
  
  value: sl.despawn,
   onChanged: (bool newvalue) {
     setState(() {
                     sl.despawn = newvalue;
                });
    
    },
),

          
       ],
         ),
        
         Row(

         children: <Widget>[
            
           Text('Trigger: '),

        Container(              
  width: 100.0,
  child: TextField(   
    controller: triggerController,                              
    style: TextStyle(
      fontSize: 15.0,
      height: 2.0,
      color: Colors.black                  
    ),
    decoration: InputDecoration(
      //hintText: sl.radius.toString(),
      labelText: 'part id',
      
          ),
  ),
),
  RaisedButton(
          onPressed: () {
            sl.next =  int.parse(triggerController.text);
          },
          child: Text('SET'),
          
        ),

          
       ],
         ),
      RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
          
        ),
         
        ],  
          
      ),
      ),
        
        );
        
  }
      
    
  }
class AdventureMessageProperties extends StatefulWidget {
  AdventureMessageProperties(this.sm);
  
  final StoryMessage sm;
  

  @override
  _AdventureMessagePropertiesState createState() => _AdventureMessagePropertiesState(sm);
}

class _AdventureMessagePropertiesState extends State<AdventureMessageProperties> {

  StoryMessage sm;
  final messageController = TextEditingController(); //lyssnar pa ett texfield behovs en for varje field. EO
  final triggerController = TextEditingController();

  _AdventureMessagePropertiesState(StoryMessage sm){
    this.sm = sm;
  }
  
  
  //sag till om ni vill ha mer kommentarer i denna kod. kandes ganska 
  //straight forward men kanske lite blind for nagon komplexitet EO

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Properties for " + sm.type + " " + sm.id.toString()),
      ),
      body: Center(
        
        
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
       
        children: <Widget>[
          Row(

         children: <Widget>[
            
           Text('Message: '),

        Container(              
  width: 200.0,
  child: TextField(  
    controller: messageController,
    maxLines: 4,                           
    style: TextStyle(
      fontSize: 15.0,
      height: 2.0,
      color: Colors.black                  
    ),
    decoration: InputDecoration(
      hintText: 'your message',
      labelText: 'message',
      
          ),
  )
  
),
RaisedButton(
          onPressed: () {
            sm.message =  messageController.text; //satter message till det i fielden
          },
          child: Text('SET'),
          
        ),

          
       ],
         ),
  Row(

         children: <Widget>[
            
           Text('stay in area '),

        Checkbox(
  
  value: sm.stayinarea,
   onChanged: (bool newvalue) { //boxen satter bool i StoryLocation EO
     setState(() {
                     sm.stayinarea = newvalue;
                });
    
    },
),

          
       ],
         ),
//   Row(

//          children: <Widget>[
            
//            Text('Despawn on triggered? '),

//         Checkbox(
  
//   value: sm.stayinarea,
//    onChanged: (bool newvalue) {
//      setState(() {
//                      sm.stayinarea = newvalue;
//                 });
    
//     },
// ),

          
//        ],
//          ),
        
         Row(

         children: <Widget>[
            
           Text('Trigger: '),

        Container(              
  width: 100.0,
  child: TextField(   
    controller: triggerController,                              
    style: TextStyle(
      fontSize: 15.0,
      height: 2.0,
      color: Colors.black                  
    ),
    decoration: InputDecoration(
      //hintText: sl.radius.toString(),
      labelText: 'part id',
      
          ),
  ),
),
  RaisedButton(
          onPressed: () {
            sm.next =  int.parse(triggerController.text);
          },
          child: Text('SET'),
          
        ),

          
       ],
         ),
      RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
          
        ),
         
        ],  
          
      ),
      ),
        
        );
        
  }
      
    
  }
