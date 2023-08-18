import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;
import 'story.dart';
import 'property_editor/part_properties.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'story_part.dart';
import 'story_location.dart';
import 'story_message.dart';




void main() => runApp(MyApp());
//har borjar appen med att loada login EO

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Maps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
//loginsidan EO
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Log in'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayOrWork()),
            );
          },
        ),
      ),
    );
  }
}
//som i sin tur loadar sidan dar man far valja mellan bygga eller spela. EO
class PlayOrWork extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play or work"),
      ),
      body: Center(
        child:
        Row(
          children: <Widget>[
        
        RaisedButton(
          onPressed: () {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Player',)),
            );
          },
          child: Text('Go Play'),
        ),
         RaisedButton(
          onPressed: () {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyBuilder()),
            );
          },
          child: Text('Go Build'),
        ),
          ]
        ),
      ),


      );
  }
}
//har har vi en massa kodduplicering som ska fixas. till en borjan har vi nastan en dubbeluppsattning av all kod i dessa tva klasser. EO
// class myhomepage ar spelaren. EO
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.mystory}) : super(key: key);
  final String title;
  final Story mystory;

  @override
  _MyHomePageState createState() => _MyHomePageState(mystory);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.mystory);
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  Map<int, Marker> _markers = {};
  Map<int, Marker> _activelocations = {};
  
  String distanceToTrigger = "error"; 
  Color pickcolor;
  Story mystory; //aventyret som passas fran buildern i nulaget.EO
  

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(59.407297, 17.946420), 
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);



    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
         _markers[0] = marker;
          circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

//onmapcreated funktionen kors nar googlemapen malas upp och ska satta ut forsta eventet som den hittar i story klassen.EO
   
  Future<void> _onMapCreated() async{

      //_markers.clear();
      Object sp =  mystory.startStory(); //hittar forsta eventet. EO
      playPart(sp); //spelar up forsta eventet. EO
      
}

//den har funktionen tar reda pa vilken typ av event som ska spelas upp och skickar den till passande funktion. EO
//den kollar attributet type i mystory EO
  void playPart(Object sp){

    if (sp != null){

    switch(sp.runtimeType){
        case StoryLocation: placeMarker(sp);
        break;
        case StoryMessage: displayMessage(sp);
        break;
      }
    }


  }

  //det har ar funktionen for event av typen StoryLocatation och behandlar dem. EO
  //tar emot en Adventure och castar den till storylocation. EO
  //addar marker och malar om screenen. EO

  void placeMarker(Object sp){
    StoryLocation sl = sp;

     Marker _marker = Marker(
          markerId: MarkerId(sl.id.toString()),
          position: LatLng(sl.markerlat, sl.markerlng), //s'tter markern location till din location, adda triggers h'r. EO
          infoWindow: InfoWindow(title: sl.id.toString()), 
      );

    
    setState((){

    if (sl.visible){
      _markers[sl.id] = _marker; //om objektet ar visible sa laggs den i _markers for att laggas ut med en marker EO
    }
    _activelocations[sl.id] = _marker; //i vilket fall hamnar de i activelocations dar triggers kommer kollas ifran. EO
    }
    );

    
  }
  //den har funktionen ska ta emot meddelanden och behandla dem. EO
  void displayMessage(Object sp){
    StoryMessage sm = sp;
    _navigateAndDisplaySelection(context, sm);

    
    //print(sm);
    

  }

   
   _navigateAndDisplaySelection(BuildContext context, StoryMessage sm) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    print('debug message');
    var result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => DisplayStoryMessage(sm)),
    );
    if (result == 'ok'){
        print("gobot");
        await new Future.delayed(const Duration(seconds: 3));
        print('debug wait');
       playPart(mystory.getPart(sm.next));
    }
    else print('nogo');
  }

//den har funktionen kollar du befinner dig inom radius av ett activelocations som inte redan ar triggered och triggar den. EO
  void checkTrigger(){

//vi itererar mapen activelocations. EO
    _activelocations.entries.forEach((e) {
 
  StoryLocation sl = mystory.getPart(e.key);

  //vi far e.value och e.key for varje object i klassen. e.key ar alltsa partid och unikt for en part. e.value ar klassen adventurelocation. EO
  //_markers[0] ar alltsa min egen location som satts utav updatemarkercircle() som kallas varje gang din position andras. EO


//har satter vi avstandet mellan din marker (_marker[0]) och e.key till totaldistance. EO

    double totalDistance = calculateDistance(_markers[0].position.latitude, _markers[0].position.longitude,
     e.value.position.latitude, e.value.position.longitude);

    
//multiplicerar med 1000 for att fa meter. EO
    totalDistance *=1000;
    
    this.setState((){
    distanceToTrigger = totalDistance.toStringAsFixed(2);
   
    if (totalDistance < sl.radius){
      pickcolor = Colors.red;
      sl.triggerednow = true;
      if (!sl.triggered){ //kollar attributet sl.triggered for att ta reda pa om denna locations blivit triggered sa att vi inte spelar upp den flera ganger. EO
        sl.triggered = true;
        if (sl.despawn){
          _markers.remove(sl.id);
        }
         playPart(mystory.playPart(sl.next)); //ska spela upp dess trigger nu. EO
        
      }
     
     
    }
     else pickcolor = Colors.green; //test grejer med farg bara for att testa. EO
     sl.triggerednow = false; //triggered now ar ett attribut for att ta reda pa om usern befinner sig inom omradet. EO

    });
    
 
    });
  }

    

  // hittar din position gor om din marker kor updatemarker och checktrigger sa fort du bytt position. EO

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 65,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
          checkTrigger();
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  
  // funktionen beraknar avstandet mellan tva punkter. EO

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
    c(lat1 * p) * c(lat2 * p) *
    (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  //stanger av locationssubscribtion EO

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      appBar: AppBar(
        title: Text(widget.title),
      ),
       
      body: Stack(
        children:<Widget>[ 
          GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: _markers.values.toSet(),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          _onMapCreated();
        },

      ),
      
      Align(
        alignment: Alignment.bottomCenter,
        
          
         //testar att triggers funkar och byter farg pa en container och skriver ut avstandet i meter till en trigger. EO
         
          child:Row(
            
            
            children: <Widget>[
          Text("distance to trigger:", style: TextStyle(fontSize:20, backgroundColor: Colors.white )),
          Text(distanceToTrigger, style: TextStyle(fontSize:40, backgroundColor: pickcolor )
         ),
            ],
          ),
         
      ),
        ],
      ),
        
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation(); //kallar getcurrentlocation for forsta gangen. har init vi locations service forsta gangen. borde kanske koras pa onCreate?. EO
          }),
          
    );
  }
}







//har borjar buildern. det ar kopia av playern all kod som ror googlemaps finns har igen. EO
//vi maste bryta ut koden som ar lika och och reusa den. EO

class MyBuilder extends StatefulWidget {
  MyBuilder({Key key}) : super(key: key);
  
  @override
  _MyBuilderState createState() => _MyBuilderState();
}

class _MyBuilderState extends State<MyBuilder> {
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;
  final Map<int, Marker> _markers = {};
  String distanceToTrigger = "error";
  Color pickcolor;
  Story mystory = new Story("teststory", 1); //klassen vi ska bygga. init med titel och id. se story.dart. EO
  List<int> items = new List<int>(); //listan over parts som ska hamna i timelinen
  int placemarker = 0; //satts till partid nar du ska satta ut ett location. om placemarker = 0 satts ingen marker ut.
  
  

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(59.407297, 17.946420), 
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);



    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
         _markers[0] = marker;
          circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

   
  

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 65,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
          
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  //kallas fran drawer (vertysfaltet pa hoger sida) nar man vill satta ut ett ny adventurelocation. EO
  //nar placemarker satts till nagot annat an 0 sa aktiveras maplistener kan man saga. onTap handler for google maps.
  void setPin(){
    if (placemarker == 0) placemarker = mystory.assignPartId();
  }


 //den har funktionen addar ett meddelande som visas nar den triggas

void addMessage(){
  int partid;
  if (placemarker == 0) partid = mystory.assignPartId(); //den har kollar om anvandaren klickat pa att satta 
  else {                                                 // ut en location men senare valt att klicka pa addmessage utan att satta ut en location
    partid = placemarker;                                // da anvander den den redan skapade partid och satter placemarker=0 och inaktiverar saledes att satta ut en marker pa mappen. EO
    placemarker = 0;
  }
  StoryMessage sm = new StoryMessage(partid,'message');
  mystory.addPart(partid,sm);

   setState(() {
        items.add(partid); // har addar vi partid som int till itemslistan som innehaller alla befintliga adventureparts. EO
        //detta gor vi i setstate for att appen ska redrawas da alla ints i listan referar till en part som representeras. EO
        // av en ikon langst ner pa storylinen .EO
       
      });



}
  //funktionen kollar vilken typ utav AdventurePart det ar och skickar vidare. kanske man kan slippa dessa genom att anvanda var? EO
  editPartProperties(Object sp){
     if (sp != null){

    switch(sp.runtimeType){
        case StoryLocation: editLocationProperties(sp);
       
        break;
        case StoryMessage: editMessageProperties(sp);
        break;
      }
    }

  }

  // denna funktion  oppnar ett window och i den kan man setta attribut i StoryLocation. EO
  void editLocationProperties (StoryLocation sl){
        //print(sl.radius);
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdventureLocationProperties(sl)), //kolla filen part_properties.dart EO
  );
}

//dirty fix tills dess vi kommer pa ett bra satt att spara ikoner i klassen
//funktionen returnerar en ikon till timelinen beroende pa vilken klass objektet ar
Icon getIcon(Object sp){

  switch(sp.runtimeType){
        case StoryLocation: return Icon(Icons.add_location); //add.location;
       
        break;
        case StoryMessage: return Icon(Icons.message);// editMessageProperties(sp);
        break;
      }
      return Icon(Icons.device_unknown);

}

      

// funktionen ska oppna en popupdialog och i den ska man kunna setta attribut i AdventureMessage. EO
  void editMessageProperties(Object sp){
    StoryMessage sm = sp;
    //print(sm.message);
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdventureMessageProperties(sm)), //kolla filen part_properties.dart EO
  );
  }

//ska spara den skapade adventureklassen till servern. ft kor den bara playern med klassen som ett argument.EO

  void saveStory(){
    {
             Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: 'Player', mystory: mystory)),
            );
          }
  }

 

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }


//tar hand om tap fran googlemapen, skickas koordinater for var man klickade.
  _handleTap(LatLng point) {
    if (placemarker != 0){
      int partid = placemarker;

  StoryLocation sl = new StoryLocation(placemarker, "location", /*Icons.add_location,*/ 10/*, Colors.green*/); //har skapas och init klassen StoryLocation. kolla story.dart. EO
    
    double markerlat = point.latitude;
    double markerlng = point.longitude;
    
     
      
      
      sl.setMarker(markerlat, markerlng); //satter sin egen marker (se storylocationklassen i story.dart) till den vi just skapade. EO
      mystory.addPart(placemarker, sl); //addar adventure till adventuremapen med partid som key /kolla story i story.dart. EO
      setState(() {
        items.add(placemarker);
         // har addar vi partid som int till itemslistan som innehaller alla befintliga adventureparts. EO
        //detta gor vi i setstate for att appen ska redrawas da alla ints i listan referar till en part som representeras. EO
        // av en ikon langst ner pa storylinen .EO
        _markers[placemarker] = Marker(
          markerId: MarkerId(partid.toString()),
          position: point,
          infoWindow: InfoWindow(
          title: sl.name,
           ),
          icon:
           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
           onTap: () {
             editPartProperties(mystory.getPart(partid));
             } 
  );
       
      });
      placemarker = 0;
    }
}
  
  

  @override
  Widget build(BuildContext context) {
     Row toolbar = new Row(
  children: <Widget>[
    
    new Expanded(child: new Text('Builder')),
    
  ]
);
    return Scaffold(
      endDrawer: Container( //verktygsfaltet pa hoger sida som poppas ut som en drawer fran hoger nar man klickar knappen pa hoger sida i appbaren. EO
        width: 70,
        child: Drawer( 
           child: ListView(
             children:  <Widget>[
                ListTile(
          leading: Icon(Icons.add_location),
          title: Text('Location'),
          onTap: () {setPin();},
        ),
          ListTile(
          leading: Icon(Icons.message),
          title: Text('Message'),
          onTap: () {addMessage();},
        ),
        ListTile(
          leading: Icon(Icons.build),
          title: Text('Build'),
          onTap: () {saveStory();},
        ),
             ],
        ),
      ),
      ),
      appBar: AppBar(
        title: toolbar,
      ),
      body: Stack(
        
        
        children:
        <Widget>[ 
          GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: _markers.values.toSet(), 
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          //_onMapCreated();
        },
        onTap: _handleTap,

      ),
      
      Positioned.fill(
        child:
      Align(
        alignment:Alignment.bottomLeft,
        
        child: Container(
          height:60,
          width: 250,
          color: Colors.pink,
        //den har displayar alla items som representeras av en int i listan items. kanske snyggare att forbereda klassen sjalv som en widget och stoppa den i listan. EO.
        child:new ListView.builder
  (
    itemCount: items.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (BuildContext ctxt, int index) {
     return new IconButton(
       icon: getIcon(mystory.getPart(items[index])),//mystory.getPart(items[index]).codepoint, ),//mystory.getPart(items[index]).icon), 
       onPressed: () {
         //print("debug55");
         editPartProperties(mystory.getPart(items[index])); //nar klickas ska ett fonster oppnas dar man editar klassens attribut. EO
       },
       
       );  
    }
  ),
      ),
      ),
      ),
        ],
        
      ),
     
        
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
          
    );
  }
}

class DisplayStoryMessage extends StatelessWidget {
  final StoryMessage sm;
  DisplayStoryMessage(this.sm);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sm.type + " " + sm.name),
      ),
      body: Center(
        
        
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
       
        children: <Widget>[
          
  Row(

         children: <Widget>[
            
           Text(sm.message),

        

          
       ],
         ),
  
      RaisedButton(
          onPressed: () {
            Navigator.pop(context, "ok");
          },
          child: Text('OK'),
          
        ),
         
        ],  
          
      ),
      ),
        
        );
        
  }
}